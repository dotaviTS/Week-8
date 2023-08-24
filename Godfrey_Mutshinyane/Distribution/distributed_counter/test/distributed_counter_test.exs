defmodule DistributedCounterTest do
  use ExUnit.Case
  doctest DistributedCounter

  test "greets the world" do
    assert DistributedCounter.hello() == :world
  end
end
