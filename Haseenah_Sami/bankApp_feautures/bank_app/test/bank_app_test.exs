defmodule BankAppTest do
  use ExUnit.Case
  doctest BankApp

  test "greets the world" do
    assert BankApp.hello() == :world
  end
end
