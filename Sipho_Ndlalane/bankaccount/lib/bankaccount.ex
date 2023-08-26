defmodule BankAccount do

  require Logger
  use GenServer

  def start_link(acc_num, initial_balance \\ 0) when is_number(initial_balance) and initial_balance >= 0 do
    val = GenServer.start_link(__MODULE__, initial_balance, name: spec_proc(acc_num))
    val
  end

  def balance(acc_num) do
    Logger.info("Request to see #{acc_num} balance recieved.")
    acc_num
    |> spec_proc()
    |> GenServer.call(:balance)
  end

  def deposit(acc_num,amount) when is_number(amount) and amount > 0 do
    Logger.info("Request to deposit R#{amount} recieved.")
    acc_num
    |> spec_proc()
    |> GenServer.cast({:deposit, amount, acc_num})
  end

  def withdraw(acc_num, amount) when is_number(amount) and amount > 0 do
    Logger.info("Request to withdraw R#{amount}, from #{acc_num} recieved.")
    acc_num
    |> spec_proc()
    |> GenServer.call({:withdraw, amount,acc_num})
  end

  def transfer(from_account, to_account, amount) do
    case BankAccount.withdraw(from_account, amount) do
      {:ok, _} ->
      case BankAccount.deposit(to_account, amount) do
        {:ok, _reason} -> {:ok, "Transfer successful"}
        error -> error
      end
      {:error, _reason} -> {:error, "Insufficient funds"}
    end
  end

  def transaction_history(acc_num, filters \\ %{}) do
    acc_num
    |> spec_proc()
    |> GenServer.call(:transaction_history)

   end
  # Callbacks
  #----------------------------------------------------------------------------------------

  def handle_call(:transaction_history,  _from, %{transactions: transactions}) do
    {:reply, %{transactions: transactions},  %{transactions: transactions}}
  end

  def handle_call({:withdraw, amount}, _from, %{balance: balance, transactions: transactions} = state) when balance >= amount do
    new_balance = balance - amount
    transaction = %BankTransaction{type: :withdraw, amount: amount, date: DateTime.utc_now(), description: "Withdraw"}
    Logger.info("R#{amount} withdrawed. \nNew balance: R#{new_balance}.")
    {:reply, %{state | balance: new_balance, transactions: [transaction | transactions]}, %{state | balance: new_balance, transactions: [transaction | transactions]}}
  end

  def handle_call({:withdraw, _amount, _acc_num}, _from, balance) do
    Logger.warning("Withdrawal failed due to insufficient funds.")
    {:reply, {:error, "Insufficient funds"}, balance}
  end

  def handle_call(:balance,  _from, %{balance: balance, transactions: transactions} = state) do
    Logger.info("Bank Balance: #{balance}")
    {:reply,  %{state | balance: balance, transactions: transactions},  %{state | balance: balance, transactions: transactions}}
  end

  def handle_cast({:deposit, amount, acc_num}, %{balance: balance, transactions: transactions} = state) do
    new_balance = balance + amount
    transaction = %BankTransaction{type: :deposit, amount: amount, date: DateTime.utc_now(), description: "Deposit"}
    Logger.info("Deposit of R#{amount} successful.\nTo account #{acc_num}.\nNew Balance R#{new_balance}")
    {:noreply, %{state | balance: new_balance, transactions: [transaction | transactions]}}
  end

  def init(initial_balance) do
    Logger.info("Bank Account started with intial balance: R#{initial_balance}")
    {:ok, %{balance: initial_balance, transactions: []}}
  end

  def spec_proc(acc_num) do
    {:via, Registry, {BankRegistry, acc_num}}
  end
end
