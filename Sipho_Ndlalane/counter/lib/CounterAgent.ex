defmodule CounterAgent do
  use GenServer
  def start_link(init_value \\ 0) do
    Agent.start_link(fn -> init_value end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, &(&1))
  end

  def increment do
    Agent.update(__MODULE__, &(&1 + 1))
  end

  def decrement do
    Agent.update(__MODULE__, &(&1 - 1))
  end

  def init(init_arg) do
    {:ok, init_arg}
  end
end
