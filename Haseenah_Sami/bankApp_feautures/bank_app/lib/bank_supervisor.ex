defmodule BankSupervisor do

  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: :bank_supervisor)
  end

  def init(:ok) do
    children = [
      {Registry, keys: :unique, name: BankRegistry}
      #{BankAccount, 1000} # Example child specification
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

end
