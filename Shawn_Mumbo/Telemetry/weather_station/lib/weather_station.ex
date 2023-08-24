defmodule WeatherStation do
  def collect_data do
    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)
    windspeed = Enum.random(5..253)
    precipitation = Enum.random(20..140)
    pressure = Enum.random(5..31)

    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity, windspeed: windspeed, precipitation: precipitation, pressure: pressure}, %{})
  end
end
