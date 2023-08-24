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
  # def hello do
  #   :world
  # end

  def collect_data do
    temperature = Enum.random(15..35)
    humidity = Enum.random(30..70)

    # ---------- Exercise 5.5: Implement System Monitoring -------
    wind_speed = Enum.random(20..120)
    pressure = Enum.random(0..12)

    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity, wind_speed: wind_speed, pressure: pressure}, %{})
  end
end
