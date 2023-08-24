defmodule WeatherStation do
  def collect_data do
    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)

    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity}, %{})
  end
end
