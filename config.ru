require "wit_ruby"
require "bitbot"

I18n.default_locale = :en

Bitbot.configure do |config|
  config.webhook_url = ENV["INCOMING_WEBHOOK_URL"]
  config.redis_connection = Redis.new(url: ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379")

  config.locales = Dir[File.expand_path("../locale/*.yml", __FILE__)]
  config.responders = Dir[File.expand_path("../responders/**/*_responder.rb", __FILE__)]

  config.load_responders

  config.listener do |listener|
    listener.token = ENV["OUTGOING_WEBHOOK_TOKEN"] || "token"

    listener.port = 80
    listener.path = "/bitbot-slack-webhook"
  end

  config.on_exception do |e, _req|
    Bitbot.log("#{e.inspect}\n#{e.backtrace.join("\n")}")
  end
end

run Bitbot.listener
