defmodule WeatherStationTest do
  use ExUnit.Case
  doctest WeatherStation

  test "greets the world" do
    assert WeatherStation.hello() == :world
  end
end
