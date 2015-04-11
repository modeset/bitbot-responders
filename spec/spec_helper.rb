require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["WUNDERGROUND_TOKEN"] = "XXX"
ENV["WIT_AI_TOKEN"] = "XXX"

require "bitbot"
require "wit_ruby"

require "fakeredis"
require "vcr"
require "webmock/rspec"

I18n.default_locale = :en

Bitbot.configure do |config|
  config.webhook_url = "http://localhost"
  config.redis_connection = Redis.new(url: "redis://127.0.0.1:6379")
  puts Dir[File.expand_path("../../locale/*.yml", __FILE__)]

  config.locales = Dir[File.expand_path("../../locale/*.yml", __FILE__)]
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  c.hook_into :webmock # or :fakeweb
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = { match_requests_on: [:uri, :method] }

  c.ignore_hosts "codeclimate.com"
end
