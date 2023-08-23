defmodule WeatherStation.TelemetryHandler do
  require Logger

  def handle_event([:weather, :data], measurements, _metadata, _config) do
    Logger.info("Collected weather data: Temperature #{measurements.temperature}°C, Humidity #{measurements.humidity}%, Wind Speed #{measurements.wind_speed}kph, Pressure #{measurements.pressure}pa")
    #:telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})
  end
end
