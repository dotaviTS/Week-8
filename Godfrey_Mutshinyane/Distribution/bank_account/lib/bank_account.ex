defmodule BankAccount do
  alias BankRegistry

    require Logger
   @moduledoc """
    Documentation for `BankAccount`.
    """
    use GenServer

    def start_link(account_number, initial_balance) do
      GenServer.start_link(__MODULE__, initial_balance, name: via_tuple(account_number))
      # Logger.info("BankAccount started with initial balance: #{initial_balance}")

    end


    @doc """
    deposit

    ## Examples

       iex> {:ok, _} = BankRegistry.start_link()
       iex> BankAccount.start_link("ACC123", 1000)
       iex> BankAccount.deposit("ACC123", 200)
       :ok
    """
     def deposit(number, amount) do
      Logger.info("Request to deposit #{number} #{amount} received.")
      number |> via_tuple() |> GenServer.cast({:deposit, amount})
    end

   @doc """
    withdraw

    ## Examples

       iex> {:ok, _} = BankRegistry.start_link()
       iex> BankAccount.start_link("ACC123", 1000)
       iex> BankAccount.withdraw("ACC123", 200)
       {:ok, 800}
    """
    def withdraw(number, amount) do
      #account =  Registry.lookup(BankRegistry, account_number)
      Logger.info("Request to withdraw #{number} #{amount} received.")
      number |> via_tuple() |> GenServer.call({:withdraw, amount})
    end
  @doc """
    balance


    ## Examples

       iex> {:ok, _} = BankRegistry.start_link()
       iex> BankAccount.start_link("ACC123", 1000)
       iex> BankAccount.balance("ACC123")
       1000

    """
     def balance(number) do
    Logger.info("Request to retrieve #{number} balance received.")

    number |> via_tuple() |> GenServer.call(:balance)
     end

  @doc """
   Transfer


    ## Examples

       iex> {:ok, _} = BankRegistry.start_link()
       iex> BankAccount.start_link("ACC123", 1000)
       iex> BankAccount.start_link("ACC456", 500)
       iex> BankAccount.transfer("ACC123", "ACC456", 200)
       :ok

    """

     def transfer(from_account, to_account, amount) do

      #from_pid = :global.whereis_name({BankRegistry, from_account})
      #to_pid = :global.whereis_name({BankRegistry, to_account})
      Logger.info("Request to transfer #{amount} from #{from_account} to #{to_account} received.")

      case BankAccount.withdraw(from_account, amount) do
        {:ok, _} ->
          case BankAccount.deposit(to_account, amount) do
            {:ok, _} -> {:ok, "Transfer successful"}
            error -> error
          end
        {:error, reason} -> {:error, reason}
      end
    end

    # def transfer(from_account, to_account, amount) do
    #   # from_account = Registry.lookup(BankRegistry, from_account) |> List.first()
    #   # to_account = Registry.lookup(BankRegistry, to_account) |> List.first()

    #   with {:ok, _} <- BankAccount.withdraw(from_account, amount),
    #        {:ok, _} <- BankAccount.deposit(to_account, amount) do
    #     {:ok, "Transfer successful"}
    #   else
    #     error -> error
    #   end
    # end

    # Callbacks

    def handle_call({:withdraw, amount}, _from, balance) when balance >= amount do
      new_balance = balance - amount
      Logger.info("Withdrawal of #{amount} successful. New balance: #{new_balance}")
      {:reply, {:ok, new_balance}, new_balance}
    end

    def handle_call({:withdraw, _amount}, _from, balance) do
      Logger.warning("Withdrawal failed due to insufficient funds.")
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

    defp via_tuple(account_number) do
      {:via, Registry, {BankRegistry, account_number}}
    end

  end
