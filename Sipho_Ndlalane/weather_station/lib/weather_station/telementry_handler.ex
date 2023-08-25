defmodule WeatherStation.TelemetryHandler do
  require Logger
  def handle_event([:weather, :data], measurements, _metadata, _config) do

    Logger.info("Collected Weather data: Temperature #{measurements.temperature}°C, Humidity #{measurements.humidity}%")
    Logger.info("Collected Pressure: #{measurements.pressure} Pa.")
    Logger.info("Collected Wind speed: #{measurements.wind_speed} m/s.")

  end
end
