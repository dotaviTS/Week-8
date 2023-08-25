defmodule WeatherStation do
  @moduledoc """
  Documentation for `WeatherStation`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WeatherStation.hello()
      :world

  """
  def hello do
    :world
  end

  def collect_data do
    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)

    # Exercise 5.5
    windspeed = Enum.random(20..120)
    pressure = Enum.random(0..12)


    :telemetry.attach("weather-data-handler", [:weather, :data], &WeatherStation.TelemetryHandler.handle_event/4, %{})


    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity, windspeed: windspeed, pressure: pressure }, %{})
  end



end
