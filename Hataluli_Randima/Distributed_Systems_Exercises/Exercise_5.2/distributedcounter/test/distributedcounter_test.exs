defmodule DistributedcounterTest do
  use ExUnit.Case
  doctest Distributedcounter

  test "greets the world" do
    assert Distributedcounter.hello() == :world
  end
end
