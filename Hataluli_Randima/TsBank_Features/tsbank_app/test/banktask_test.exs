defmodule BanktaskTest do
  use ExUnit.Case
  doctest BankAccount, async: true
  alias BankTask

# Exercise 6 for test
 test "verifyinng concurrent deposits and withdrawals" do
  #initial balance set to R1000
  BankTask.start_link(1000)

  tasks =
    1..5
    |> Enum.map(fn _ ->
      Task.async(fn ->
        BankTask.deposit(100)
        BankTask.withdraw(50)
      end)
    end)

    Enum.each(tasks, &Task.await/1)

    assert BankTask.balance() == 1250
 end


end
