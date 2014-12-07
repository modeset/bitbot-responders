require 'wit_ruby'
require 'bitbot'

I18n.default_locale = :en
Redis.current = Redis.new(url: ENV['REDISTOGO_URL'] || 'redis://127.0.0.1:6379')

Bitbot.configure do |config|
  config.user_name = 'bitbot'
  config.full_name = 'Bit Bot'

  config.webhook_url = ENV['INCOMING_WEBHOOK_URL']
  config.redis_connection = Redis.current

  config.locales = Dir[File.expand_path('../locale/*.yml', __FILE__)]
  config.responders = Dir[File.expand_path('../responders/**/*_responder.rb', __FILE__)]

  config.listener :web do |listener|
    listener.token = ENV['OUTGOING_WEBHOOK_TOKEN'] || 'token'

    listener.port = 80
    listener.path = '/bitbot-slack-webhook'
  end

  config.load_responders
end

class Bitbot::Listener::Web
  def handle_exception(req, e)
    puts "#{e.inspect}\n#{e.backtrace.join("\n")}"
  end
end

run Bitbot.listener(:web)

