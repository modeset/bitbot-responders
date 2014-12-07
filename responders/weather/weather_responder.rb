require 'cgi'
require 'open-uri'

class WeatherResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  TOKEN = ENV['WUNDERGROUND_TOKEN']

  category 'Weather'
  help 'weather:conditions <location>', description: 'Displays current conditions for a given location',
    examples: ['Denver CO weather', 'weather for Denver CO', 'current conditions for Denver']
  help 'weather:forecast <location>', description: 'Fetches a weather forecast for a given location',
    examples: ['what\'s the forecast for Denver CO?', 'Denver CO forecast']
  help 'weather:moon <location>', description: 'Displays the moon phase information for a given location',
    examples: ['Denver CO moon', 'moon for Denver CO', 'moon phase for Denver']

  intent 'weather_conditions', :conditions, entities: { location: nil }
  route :conditions, /^weather:conditions\s?(.*)?$/ do |location|
    location = 'Denver CO' if location.to_s.empty?
    location, response = results_for(:conditions, location)
    info = response.fetch('current_observation')

    respond_with(conditions_message(info, location))
  end

  intent 'weather_forecast', :forecast, entities: { location: nil }
  route :forecast, /^weather:forecast\s?(.*)?$/ do |location|
    location = 'Denver CO' if location.to_s.empty?
    location, response = results_for(:forecast, location)
    info = response.fetch('forecast').fetch('txt_forecast').fetch('forecastday')

    respond_with(forecast_message(info, location))
  end

  intent 'weather_moon', :moon, entities: { location: nil }
  route :moon, /^weather:moon\s?(.*)?$/ do |location|
    location = 'Denver CO' if location.to_s.empty?
    location, response = results_for(:astronomy, location)
    info = response.fetch('moon_phase')

    respond_with(moon_phase_message(info, location))
  end

  private

  def results_for(resource, location)
    url = "http://autocomplete.wunderground.com/aq?query=#{CGI.escape(location)}"
    json = JSON.parse(open(url).read)
    location_query = json['RESULTS'][0]['l']
    location_name = json['RESULTS'][0]['name']

    url = "http://api.wunderground.com/api/#{TOKEN}/#{resource}#{location_query}.json"
    [location_name, JSON.parse(open(url).read)]
  rescue
    raise(Bitbot::Response, "I was unable to find any locations from \"#{location}\".")
  end

  def conditions_message(info, location)
    winds = info['wind_string'].empty? ? '' : "Winds #{info['wind_string'].downcase}."
    text = "#{info['weather']}, feels like #{info['feelslike_f'].to_i}°. #{winds}"
    {
      text: "#{t("weather.icons.#{info['icon']}")} Weather conditions for *#{location}*.",
      attachments: [
        title: text,
        fallback: text,
        fields: [
          {title: 'Temperature', value: "#{info['temp_f'].to_i}° (#{info['temp_c'].to_i}c)", short: true},
          {title: 'Relative Humidity', value: info['relative_humidity'], short: true},
        ]
      ]
    }
  end

  def forecast_message(periods, location)
    fields = []
    (0..periods.length - 1).step(2) do |i|
      info = periods[i]
      value = "#{t("weather.icons.#{info['icon']}")} #{info['fcttext'].gsub(' MPH ', ' mph ')}"
      fields << {title: info['title'], value: value, short: false}
    end

    {
      text: ":globe_with_meridians: Weather forecast for *#{location}*.",
      attachments: [
        fallback: 'Unable to display forecasts in this client.',
        fields: fields
      ]
    }
  end

  def moon_phase_message(info, location)
    phase = info['phaseofMoon']
    {
      text: "#{t("weather.moons.#{phase.downcase.gsub(' ', '')}")} The moon is currently in the _#{phase}_ phase in *#{location}*."
    }
  end

end