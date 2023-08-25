
  test "verifying the intial balance" do
    # Intial amount of 100 in the account
   {:ok, pid} = BankAccount.start_link(100)
   assert BankAccount.balance(pid)  == 100
  end

  test "check deposit working" do
      {:ok, pid} = BankAccount.start_link(100)
      #Depositing 100, whiich will return current balance of 200
       BankAccount.deposit(pid, 100)
       assert BankAccount.balance(pid) == 200
  end

  test "withdraw with right amount" do
     {:ok, pid} = BankAccount.start_link(100)
     # Withdrawing a right amount and it gives you right amount of 50
     BankAccount.withdraw pid, 50
     assert BankAccount.balance(pid)  == 50
   end

   test "withdraw with wrong amount" do
    {:ok, pid} = BankAccount.start_link(100)
    #BankAccount.withdraw pid, 150
    # widrwaing high amount
    assert BankAccount.withdraw pid, 150  == {:error, "Insufficient funds"}
   end

   test "Showing for concurrent withdraw and deposit" do
    {:ok, pid} = BankAccount.start_link(100)
    BankAccount.deposit(pid,500)
    BankAccount.withdraw(pid, 200)

    assert BankAccount.balance(pid) == 400
   end