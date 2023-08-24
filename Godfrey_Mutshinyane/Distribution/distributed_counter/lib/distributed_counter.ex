defmodule DistributedCounter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{:value => 0})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:increment, amount}, state) do
    new_value = state[:value] + amount
    {:noreply, %{state | :value => new_value}}
  end

  def handle_call(:get_value, _from, state) do
    {:reply, state[:value], state}
  end
end
