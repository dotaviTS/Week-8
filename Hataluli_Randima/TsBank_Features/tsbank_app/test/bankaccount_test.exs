defmodule BankaccountTest do
  use ExUnit.Case
  doctest BankAccount, async: true
#   alias BankTask
test "Intital Balance" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 500)
  assert BankAccount.balance("ACC123") == 500
end

test "Deposit to specific account" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 500)
  BankAccount.deposit("ACC123", 200)
  assert BankAccount.balance("ACC123") == 700
end

test "Withdraw with sufficient funds" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 1000)
  BankAccount.withdraw("ACC123", 200)
  assert BankAccount.balance("ACC123") == 800
end

test "Withdraw with insufficient funds" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 1000)
  assert BankAccount.withdraw("ACC123", 1500) == {:error, "Insufficient funds"}
  assert BankAccount.balance("ACC123") == 1000
end

#6. Writing tests for Concurrency
test "concurrent deposits and withdrawals" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 1000)

  tasks =
    1..10
    |> Enum.map(fn _ ->
      Task.async(fn ->
        BankAccount.deposit("ACC123", 100)
        BankAccount.withdraw("ACC123", 50)
      end)
    end)

  Enum.each(tasks, &Task.await/1)

  assert BankAccount.balance("ACC123") == 1500
end

test "transfer money between two accounts" do
  {:ok, _} = BankRegistry.start_link()
  BankAccount.start_link("ACC123", 1000)
  BankAccount.start_link("ACC456", 500)

  assert BankAccount.transfer("ACC123", "ACC456", 200) == :ok
end

# # Exercise 6 for test
# test "verifyinng concurrent deposits and withdrawals" do
#   #initial balance set to R1000
#    BankAccount.start_link(1000)

#   tasks =
#     1..5
#     |> Enum.map(fn _ ->
#       Task.async(fn ->
#         BankAccount.deposit(100)
#         BankAccount.withdraw(50)
#       end)
#     end)

#     Enum.each(tasks, &Task.await/1)

#     assert BankAccount.balance() == 1250



end
