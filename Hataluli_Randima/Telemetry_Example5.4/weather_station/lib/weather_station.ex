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

    :telemetry.execute([:weather, :data], %{temperature: temperature, humidity: humidity}, %{})
  end
end
