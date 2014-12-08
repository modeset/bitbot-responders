class StandupResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'General'

  help 'general:standup',
       description: 'Responds with list of what everyone is working on.',
       examples: ['what are people working on?', 'what\'s @jejacks0n working on today?']

  intent 'standup_list', :standup_list, entities: {contact: nil}

  route :standup_list, /^general:standup\s?(.*)?$/i do |username|
    keys = connection.keys("bitbot:standup:#{username.to_s.empty? ? '*' : "#{username}:*"}")
    messages = keys.map { |key| Bitbot::Message.new(JSON.parse(connection.get(key))) }

    respond_with(attachments: [tasks_for(messages)]) do
      "Okay @#{message.user_name}, here's what's going on:"
    end
  end

  route :standup, /^standup: (.*)/i do |task|
    message.task = task
    connection.setex(key_for_redis(message), 60 * 60 * 20, message.to_json)
    false
  end

  private

  def key_for_redis(message)
    "bitbot:standup:#{message.user_name}:#{message.channel}:#{message.channel_id}:#{self.class.name}"
  end

  def tasks_for(messages)
    fields = messages.map { |m| {title: m.user_name, value: m.task, short: false} }
    {fallback: 'Unable to display on this client.', fields: fields}
  end

end
