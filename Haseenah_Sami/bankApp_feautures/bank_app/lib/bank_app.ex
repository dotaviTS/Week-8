defmodule BankApp do
alias BankRegistry
alias Transaction
use Tabula, style: :github_md

  require Logger
  use GenServer

  @type t :: %Transaction{
    type: String.t(),
    amount: number(),
    date: DateTime.t() | nil,
    description: String.t()

  }
  def start_link(account_number, initial_balance) do
    GenServer.start_link(__MODULE__, initial_balance, name: via_tuple(account_number))

  end

   def deposit(number, amount) do
    Logger.info("Request to deposit #{amount} from #{number} received.")
    number |> via_tuple() |> GenServer.cast({:deposit, amount})
  end

  def withdraw(number, amount) do
    Logger.info("Request to withdraw #{amount} from #{number} received.")
    number |> via_tuple() |> GenServer.call({:withdraw, amount})

  end

   def balance(number) do
  Logger.info("Request to retrieve #{number} balance received.")
  number |> via_tuple() |> GenServer.call(:balance)
   end

  #  defp filter(transactions, type) do
  #   transactions
  #   |> Enum.filter(fn %{type: type_transaction} -> type_transaction == type end)
  # #   transactions
  # #   |> Enum.sort_by(& &1.date)
  #  end

   def transaction_history(number) do
    number |> via_tuple() |> GenServer.call(:transaction_history) |> print_table
   end

   def transfer(from_account, to_account, amount) do
    # from_account_pid = Registry.lookup(BankRegistry, from_account) |> List.first()
    # to_account_pid = Registry.lookup(BankRegistry, to_account) |> List.first()

    Logger.info("Request to transfer #{amount} from #{from_account} to #{to_account} received.")

    case BankApp.withdraw(from_account, amount) do
      {:ok, _} ->
        case BankApp.deposit(to_account, amount) do
          #{:ok, _} -> {:ok, "Transfer successful"}
          error -> error
        end
      {:error, reason} -> {:error, reason}
    end
  end

  # Callbacks

  def handle_call({:withdraw, amount}, _from, %{balance: balance, transactions: transactions} = state) when balance >= amount do
    new_balance = balance - amount
    transaction = %Transaction{type: :withdraw, amount: amount, date: DateTime.utc_now(), description: "Withdraw"}
    Logger.info("Withdrawal of #{amount} successful. New balance: #{new_balance}")
    {:reply, %{state | balance: new_balance, transactions: [transaction | transactions]}, %{state | balance: new_balance, transactions: [transaction | transactions]}}
  end

  def handle_call({:withdraw, _amount}, _from, balance) do
    Logger.warning("Withdrawal failed due to insufficient funds.")
    {:reply, {:error, "Insufficient funds"}, balance}
  end

   def handle_call(:balance,  _from, %{balance: balance, transactions: transactions} = state) do
    Logger.info("Balance #{balance} received")
    {:reply,  %{state | balance: balance, transactions: transactions},  %{state | balance: balance, transactions: transactions}}
  end

  def handle_call(:transaction_history,  _from, %{transactions: transactions}) do
    #Logger.info("Balance #{balance} received")

    #filter = filter(transactions, type)
    {:reply, %{transactions: transactions},  %{transactions: transactions}}
  end

  def handle_cast({:deposit, amount}, %{balance: balance, transactions: transactions} = state) do
    new_balance = balance + amount
    transaction = %Transaction{type: :deposit, amount: amount, date: DateTime.utc_now(), description: "Deposit"}
    Logger.info("Deposit of #{amount} successful. New balance: #{new_balance}")
    #{:noreply, new_balance}
    {:noreply, %{state | balance: new_balance, transactions: [transaction | transactions]}}
  end


  def init(initial_balance) do
    Logger.info("Bank account created with initial balance: #{initial_balance}")
    {:ok, %{balance: initial_balance, transactions: []}}
  end

  defp via_tuple(account_number) do
    {:via, Registry, {BankRegistry, account_number}}
    #:global.whereis_name({account_number})
  end


end
