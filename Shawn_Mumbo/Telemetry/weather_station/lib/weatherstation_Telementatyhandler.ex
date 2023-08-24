defmodule WeatherStation.TelemetryHandler do
  require Logger

  def handle_event([:weather, :data], measurements, _metadata, _config) do
    Logger.info("Collected weather data: Temperature #{measurements.temperature}°C, Humidity #{measurements.humidity}%")
    :telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})
  end
end

#:telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})
