defmodule BankAccount do
alias Transaction
  require Logger
  #
    use GenServer
    #type: nil, amount: 0, date: nil, description: nil

    @type t :: %Transaction{
      type: String.t(),
      amount: Integer.t(),
      date: DateTime.t(),
      description: String.t()
    }

    @spec start_link(any, number) :: :ignore | {:error, any} | {:ok, pid}
    def start_link(account_number, initial_balance) when is_number(initial_balance) and initial_balance >= 0 do
      GenServer.start_link(__MODULE__, initial_balance, name: spec_proc(account_number))

    end

    # def start_link( initial_balance) when is_number(initial_balance) and initial_balance >= 0 do
    #   result =  GenServer.start_link(__MODULE__, initial_balance, name: BankSupervisor)
    #    result
    #  end


    def deposit( account_number,amount) when is_number(amount) and amount > 0 do
      Logger.info("Request to deposit #{amount} received.")
       account_number
      |> spec_proc() # it passes the process id , it couldnot find it
      |> GenServer.call({:deposit, amount, account_number})
    end

    def withdraw(account_number, amount) when is_number(amount) and amount > 0 do
      Logger.info("Request to withdraw #{amount} received.")
      account_number
      |> spec_proc()
      |> GenServer.call( {:withdraw, amount,account_number})
    end

    def balance(account_number) do
      Logger.info("Request to retrieve balance received.")
      account_number
      |> spec_proc()
      |> GenServer.call({:balance,account_number})
    end

    def transaction_history(account_number,  filters \\ %{}) do
    #   account_number
    #   |> spec_proc()
    #  |>  GenServer.call( {:transaction_history})

    GenServer.call({:via, Registry, {BankRegistry, account_number}}, {:transaction_history, filters})
      #GenServer.call({:via, Registry, {BankRegistry, account_number}}, {:transaction_history})
    end


    def transfer(from_account, to_account, amount) do

      #  from_account
      #  |> spec_proc()
      #  from_account =  Registry.lookup(BankRegistry, from_account) |> List.first()

      #  to_account
      #  |> spec_proc()
      # to_account = Registry.lookup(BankRegistry, to_account) |> List.first()
    #   now_account = spec_proc(from_account)
       #from_account_pid = Registry.lookup(BankRegistry, now_account) |> List.first()
     #  no_account = spec_proc(to_account)
       #to_account_pid = Registry.lookup(BankRegistry, no_account) |> List.first()

        from_pid = :global.whereis_name({BankRegistry, from_account})
       IO.inspect(from_pid)
        to_pid = :global.whereis_name({BankRegistry, to_account})
       IO.inspect(to_pid)
      #  from_pid
       case BankAccount.withdraw(from_pid, amount) do
         {:ok, _} ->
           case BankAccount.deposit(to_pid, amount) do
             {:ok, _reason} -> {:ok, "Transfer successful"}
            error -> error
           end
        {:error, _reason} -> {:error, "Insufficient funds"}
       end
    end

    # Callbacks

    def handle_call({:withdraw, amount, account_number}, _from, %{balance: balance, transactions: transactions} = state) when balance >= amount do
      new_balance = balance - amount
      transaction = %Transaction{type: :withdraw, amount: amount, date: DateTime.utc_now(), description: "Withdrawal"}
      Logger.info("Withdrawal of #{amount} successful. New balance: #{new_balance} From this account #{account_number}")
      {:reply, %{state | balance: new_balance, transactions: [transaction | transactions]}, %{state | balance: new_balance, transactions: [transaction | transactions]}}
    end

    def handle_call({:withdraw, _amount, _account_number}, _from, balance) do
      Logger.warning("Withdrawal failed due to insufficient funds.")
      {:reply, {:error, "Insufficient funds"}, balance}
    end

    def handle_call({:balance, account_number}, _from,  %{balance: balance, transactions: transactions} = state) do
      Logger.info("Balance: #{balance} From this account#{account_number}")
      {:reply, %{state | balance: balance, transactions: [ transactions]}, state}
    end

    def handle_call({:transaction_history, filters}, _from, %{ transactions: transactions} = state ) do
     # Logger.info("Balance: #{state} From this account")
     IO.inspect( hata = filter_by_country(transactions,filters))
      Logger.info("Balance: #{hata} From this account}")
      #IO.puts(hata)
      {:reply,hata , state}
    end


    # third argument they doing some pattern match
    def handle_call({:deposit, amount, account_number}, _from, %{balance: balance, transactions: transactions} = state) do
      new_balance = balance + amount
      transaction = %Transaction{type: :deposit, amount: amount, date: DateTime.utc_now(), description: "Deposit"}
      Logger.info("Deposit of #{amount} successful. New balance: #{new_balance} The account is #{account_number}")
      #updating
      {:reply, %{state | balance: new_balance, transactions: [transaction | transactions]}, %{state | balance: new_balance, transactions: [transaction | transactions]}}
    end

    def init(initial_balance) do
      Logger.info("Bank account created with initial balance: #{initial_balance}")
     # {:ok, initial_balance}

     {:ok, %{balance: initial_balance, transactions: []}}
    end


    defp spec_proc(account_number) do
       {:via, Registry, {BankRegistry, account_number}}
     end

     # Function to filter by type of transaction
     defp filter_by_country(my_stryct, %{type: name} = hata) do

     # for %{name: name} <- all(), do: name
      my_stryct
      # extracting thr coutry name by pattern match
      |> Enum.filter(fn name -> name == ":deposit" end)
    end

    defp filterd_data(%{ type: name} = hata), do: {name == ":deposit"}


    # defmodule FilterMapExample do
    #   def filter_users(users) do
    #     Enum.filter_map(
    #       users,
    #       fn(user) -> has_name?(user) end,
    #       fn(user) -> filterd_data(user) end
    #     )
    #   end

    #   defp has_name?(%{full_name: _full_name}), do: true
    #   defp has_name?(%{username: _username}), do: true
    #   defp has_name?(_), do: nil

    #   defp filterd_data(%{id: id, full_name: name}), do: {id, String.upcase(name)}
    #   defp filterd_data(%{id: id, username: name}), do: {id, String.upcase(name)}
    # end
end
