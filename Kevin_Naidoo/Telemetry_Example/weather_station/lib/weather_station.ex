defmodule WeatherStation do
    def collect_data do

      temperature = Enum.random(15..35)
      humidity = Enum.random(30..70)
      wind_speed  = Enum.random(12..120)
      pressure = Enum.random(0..12)
      :telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})
      :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity, wind_speed: wind_speed, pressure: pressure}, %{})
    end
  end
