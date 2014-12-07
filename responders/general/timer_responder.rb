class TimerResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'General'
  help 'general:timer <seconds>', description: 'Creates a timer that will alert you when it\'s done',
    examples: ['set a timer for 4 minutes.', 'timebox this to 30 minutes.']

  intent 'timer', :timer, entities: { duration: ->(e) { e['normalized']['value'] } }
  route :timer, /^general:timer\s?(\d+)?$/i do |seconds|
    seconds ||= 300
    seconds = seconds.to_i

    delay seconds do
      announce <<-MSG.strip_heredoc
        :alarm_clock: Okay, @#{message.user_name} your timer's done.
      MSG
    end

    respond_with <<-MSG.strip_heredoc
      :#{clock_emoji(seconds)}: Okay @#{message.user_name}, I've set a timer for #{duration_of_seconds_in_words(seconds)}.
    MSG
  end

  private

  def duration_of_seconds_in_words(seconds)
    results = [[60, :second], [60, :minute], [24, :hour], [1000, :day]].map do |count, name|
      if seconds > 0
        seconds, mod = seconds.divmod(count)
        pluralize(mod, name) if mod > 0
      end
    end
    results.compact.reverse.join(' ')
  end

  def pluralize(count, str)
    count > 1 ? "#{count} #{str}s" : "#{count} #{str}"
  end

  def clock_emoji(seconds)
    time = Time.now + seconds
    hour = time.strftime('%l').to_i
    minute = time.strftime('%M').to_i
    if minute < 15
      minute = nil
    elsif minute < 30
      minute = 30
    elsif minute < 45
      minute = 30
    else
      hour += 1
      minute = nil
    end
    "clock#{hour}#{minute}"
  end

end
