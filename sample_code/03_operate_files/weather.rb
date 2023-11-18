# frozen_string_literal: true

require "csv"
require "json"
require "open-uri"
require "yaml"

URL = "https://www.jma.go.jp/bosai/forecast/data/forecast/130000.json"

URI.parse(URL).open do |io|
  forecast = JSON.parse(io.read)

  time_defines = forecast.dig(0, "timeSeries", 0, "timeDefines")

  areas = forecast.dig(0, "timeSeries", 0, "areas")
  tokyo_area = areas.find { |area| area.dig("area", "name") == "東京地方" }

  result = time_defines.map.with_index do |time, index|
    { time: time,
      weather: tokyo_area["weathers"][index],
      wind: tokyo_area["winds"][index],
      waves: tokyo_area["waves"][index] }
  end

  # JSON
  File.open("out/weather.json", "w") do |file|
    file.puts JSON.pretty_generate(result)
  end

  # CSV
  CSV.open("out/weather.csv", "w") do |csv|
    csv << result.first.keys
    result.each do |row|
      csv << [row[:time], row[:weather], row[:wind], row[:waves]]
    end
  end

  # YAML
  YAML.dump(result, File.open("out/weather.yml", "w"))
end
