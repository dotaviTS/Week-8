defmodule BankSupervisor do
  use Supervisor
  alias BankAccount

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: :bank_supervisor)
  end

  def init(:ok) do
    children = [
      {BankAccount, 1000} # Example child specification
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
