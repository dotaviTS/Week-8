defmodule DistributedCounterAPI do
  def increment(counter_pid, amount) do
    GenServer.cast(counter_pid, {:increment, amount})
  end

  def get_value(counter_pid) do
    GenServer.call(counter_pid, :get_value)
  end
end
