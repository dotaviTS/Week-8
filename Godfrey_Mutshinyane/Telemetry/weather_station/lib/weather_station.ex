defmodule WeatherStation do
  def collect_data do


    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)
    #windspeed = Enum.random(20..120)
    #pressure = Enum.random(0..20)


    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity}, %{})
  end
end
