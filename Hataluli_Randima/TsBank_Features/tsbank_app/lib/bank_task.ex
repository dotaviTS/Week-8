defmodule BankTask do

  # exercise 7
  require Logger
  #
    use GenServer

    def start_link(initial_balance) when is_number(initial_balance) and initial_balance >= 0 do
      result = GenServer.start_link(__MODULE__, initial_balance,name: :bank_account)
     #  Logger.info("BankAccount started with initial balance: #{initial_balance}")
    #GenServer.start_link(__MODULE__, initial_balance, name: {:via, Registry, {BankRegistry, account_number}})
      result
    end


    def deposit(amount) when is_number(amount) and amount > 0 do
      Logger.info("Request to deposit #{amount} received.")
      GenServer.cast(:bank_account, {:deposit, amount})
    end

    def withdraw(amount) when is_number(amount) and amount > 0 do
      Logger.info("Request to withdraw #{amount} received.")
      GenServer.call(:bank_account, {:withdraw, amount})
    end

    def balance() do
      Logger.info("Request to retrieve balance received.")
      GenServer.call(:bank_account, :balance)
    end


    # Callbacks

    def handle_call({:withdraw, amount}, _from, balance) when balance >= amount do
      new_balance = balance - amount
      Logger.info("Withdrawal of #{amount} successful. New balance: #{new_balance}")
      {:reply, {:ok, new_balance}, new_balance}
    end

    def handle_call({:withdraw, _amount}, _from, balance) do
      Logger.warn("Withdrawal failed due to insufficient funds.")
      {:reply, {:error, "Insufficient funds"}, balance}
    end

    def handle_call(:balance, _from, balance) do
      {:reply, balance, balance}
    end

    def handle_cast({:deposit, amount}, balance) do
      new_balance = balance + amount
      Logger.info("Deposit of #{amount} successful. New balance: #{new_balance}")
      {:noreply, new_balance}
    end

    def init(initial_balance) do
      Logger.info("Bank account created with initial balance: #{initial_balance}")
      {:ok, initial_balance}
    end

    # Doing exercise 1
    def checking_exercise1 do
      #intial amount start 500
      start_link(500)
      deposit(300)
      withdraw(200)

    end

    # For exercise 2  concurrent deposit
    def checking_exercise2 do
      start_link(1000)

      tasks =
        1..5
        |> Enum.map(fn _ ->
          Task.async(fn ->
            deposit(100)
          end)
        end)

      Enum.each(tasks, &Task.await/1)

    end


     # For exercise 2  concurrent deposit using spawn
    #  def checking_exercise22 do
    #   start_link(1000)

    #   tasks =
    #     1..5
    #     |> Enum.map(fn _ ->
    #       Task.async(fn ->
    #         deposit(100)
    #       end)
    #     end)

    #   Enum.each(tasks, &Task.await/1)
    #   balance()

    # end

    # For exercise 3 to do concurrent withdrawals
    def checking_exercise3 do
      start_link(1000)

      tasks =
        1..5
        |> Enum.map(fn _ ->
          Task.async(fn ->
            withdraw(100)
          end)
        end)

      Enum.each(tasks, &Task.await/1)

    end

    # Doing exercise 4 for mixed deposits and withdrawls
    # it does 5 for each withdrawal and deposit

    def checking_exercise4 do
      start_link(1000)
      tasks1 =
        1..5
        |> Enum.map(fn _ ->
          Task.async(fn ->
             deposit(100)
            withdraw(50)
          end)
        end)

        # tasks2 =
        #   1..5
        #   |> Enum.map(fn _ ->
        #     Task.async(fn ->
        #       BankAccount.deposit(100)
        #       BankAccount.withdraw(50)
        #     end)
        #   end)

        Enum.each(tasks1, &Task.await/1)
    end


    # Doing for Error handling evercise 5
    def checking_exercise5 do
      start_link(500)

      case withdraw(600) do
       {:error, "Insufficient funds"} -> IO.puts("Your account has low money")
       _ -> IO.puts("You are top dog")
      end
    end
  end
