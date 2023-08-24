defmodule WeatherStation.TelemetryHandler do
  require Logger
  def handle_event([:weather, :data], measurements, _metadata, _config) do

    Logger.info("Collected weather data: Temperature #{measurements.temperature}°C, Humidity #{measurements.humidity}%")
    Logger.info("Collected pressure: #{measurements.pressure} Pa")
    Logger.info("Collected wind speed: #{measurements.wind_speed} m/s")

  end
end

#
