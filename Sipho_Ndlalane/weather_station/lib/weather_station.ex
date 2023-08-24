defmodule WeatherStation do
  def collect_data do
    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)

    pressure = Enum.random(15..90)
    wind_speed = Enum.random(5..120)


    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity, wind_speed: wind_speed, pressure: pressure}, %{})
  end
end
###############################
#:telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})
