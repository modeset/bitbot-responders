require 'spec_helper'
require_relative('../../responders/weather/weather_responder')

describe WeatherResponder do
  let(:message) { Bitbot::Message.new(text: text, user_name: 'archer') }

  describe 'conditions', vcr: true do
    let(:text) { 'weather:conditions' }

    it 'responds with the weather conditions' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":cloud: Weather conditions for *Denver, Colorado*.")

      attachment = response[:attachments][0]
      expect(attachment[:title]).to eq('Mostly Cloudy, feels like 67°. Winds from the ne at 5.0 mph gusting to 5.0 mph.')
      expect(attachment[:fallback]).to eq('Mostly Cloudy, feels like 67°. Winds from the ne at 5.0 mph gusting to 5.0 mph.')
      expect(attachment[:fields][0][:value]).to eq('67° (19c)')
      expect(attachment[:fields][1][:value]).to eq('37%')
    end

    describe 'with wit' do
      let(:text) { 'what are the weather conditions in Denver?' }

      it 'responds with the weather conditions' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":partly_sunny: Weather conditions for *Denver, Colorado*.")
      end

    end
  end

  describe 'forecast', vcr: true do
    let(:text) { 'weather:forecast' }

    it 'responds with the weather forecast' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":globe_with_meridians: Weather forecast for *Denver, Colorado*.")

      attachment = response[:attachments][0]
      expect(attachment[:fallback]).to eq('Unable to display forecasts in this client.')
      expect(attachment[:fields][0][:title]).to eq('Saturday')
      expect(attachment[:fields][0][:value]).to eq(':sunny: A few clouds. Lows overnight in the mid 40s.')
      expect(attachment[:fields][1][:title]).to eq('Sunday')
      expect(attachment[:fields][1][:value]).to eq(':partly_sunny: Intervals of clouds and sunshine. High 71F. Winds SSW at 10 to 15 mph.')
    end

    describe 'with wit' do
      let(:text) { 'what\'s the forecast for anchorage alaska?' }

      it 'responds with the weather conditions' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":globe_with_meridians: Weather forecast for *Anchorage, Alaska*.")
      end

    end
  end

  describe 'moon', vcr: true do
    let(:text) { 'weather:moon' }

    it 'responds with the moon phase' do
      response = subject.respond_to(message)
      expect(response[:text]).to eq(":waxing_gibbous_moon: The moon is currently in the _Waxing Gibbous_ phase in *Denver, Colorado*.")
    end

    describe 'with wit' do
      let(:text) { 'what does the moon look like in beverly hills california?' }

      it 'responds with the weather conditions' do
        response = subject.respond_to(message)
        expect(response[:text]).to eq(":waxing_gibbous_moon: The moon is currently in the _Waxing Gibbous_ phase in *Beverly Hills, California*.")
      end

    end
  end
end
