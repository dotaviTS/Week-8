defmodule TsbankAppTest do
  use ExUnit.Case
  doctest TsbankApp

  test "greets the world" do
    assert TsbankApp.hello() == :world
  end
end
