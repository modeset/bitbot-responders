require "cgi"
require "open-uri"

class WeatherResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  TOKEN = ENV["WUNDERGROUND_TOKEN"]

  category "Weather"

  help "weather:conditions <location>",
       description: "Displays current conditions for a given location",
       examples: ["Denver CO weather", "weather for Denver CO", "current conditions for Denver"]

  help "weather:forecast <location>",
       description: "Fetches a weather forecast for a given location",
       examples: ["what's the forecast for Denver CO?", "Denver CO forecast"]

  help "weather:moon <location>",
       description: "Displays the moon phase information for a given location",
       examples: ["Denver CO moon", "moon for Denver CO", "moon phase for Denver"]

  {
    conditions: ["current_observation"],
    forecast:   ["forecast/txt_forecast/forecastday"],
    moon:       ["moon_phase", :astronomy]
  }.each do |method, (path, action)|
    intent "weather_#{method}", method, entities: { location: nil }

    route method, /^weather:#{method}\s?(.*)?$/ do |location|
      location, info = results_for(action || method, location, path)
      respond_with(send("#{method}_message", info, location))
    end
  end

  private

  def results_for(resource, location, path = "")
    location_name, location_query = resolve_location(location)
    response = JSON.parse(open("http://api.wunderground.com/api/#{TOKEN}/#{resource}#{location_query}.json").read)
    path.split("/").each { |path_part| response = response.fetch(path_part) }

    [location_name, response]
  rescue
    raise(Bitbot::Response, "I was unable to find any data for \"#{location}\".")
  end

  def conditions_message(info, location)
    winds = info["wind_string"].empty? ? "" : "Winds #{info['wind_string'].downcase}."
    text = "#{info['weather']}, feels like #{info['feelslike_f'].to_i}°. #{winds}"
    {
      text: "#{t("weather.icons.#{info['icon']}")} Weather conditions for *#{location}*.",
      attachments: [
        title: text,
        fallback: text,
        fields: [
          { title: "Temperature", value: "#{info['temp_f'].to_i}° (#{info['temp_c'].to_i}c)", short: true },
          { title: "Relative Humidity", value: info["relative_humidity"], short: true },
        ]
      ]
    }
  end

  def forecast_message(periods, location)
    fields = []
    (0..periods.length - 1).step(2) do |i|
      info = periods[i]
      value = "#{t("weather.icons.#{info['icon']}")} #{info['fcttext'].gsub(' MPH ', ' mph ')}"
      fields << { title: info["title"], value: value, short: false }
    end

    text = ":globe_with_meridians: Weather forecast for *#{location}*."
    {
      text: text,
      attachments: [
        fallback: text,
        fields: fields
      ]
    }
  end

  def moon_message(info, location)
    phase = info["phaseofMoon"]
    emoji = t("weather.moons.#{phase.downcase.gsub(' ', '')}")
    {
      text: "#{emoji} The moon is currently in the _#{phase}_ phase in *#{location}*."
    }
  end

  def resolve_location(location)
    location = "Denver CO" if location.to_s.empty?

    url = "http://autocomplete.wunderground.com/aq?query=#{CGI.escape(location)}"
    json = JSON.parse(open(url).read)
    [json["RESULTS"][0]["name"], json["RESULTS"][0]["l"]]
  end
end
