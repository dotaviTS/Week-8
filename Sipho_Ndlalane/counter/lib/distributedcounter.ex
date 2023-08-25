defmodule DistributedCounter do

  def start_counter(name) do
    :global.register_name(DistributedCounter, self())
    counter = Agent.start_link(fn -> 0 end, name: name)
    {:ok, counter}
  end

  def increment(counter) do
    Agent.update(counter, fn value -> value + 1 end)
  end

  def get_value(counter) do
    Agent.get(counter, fn value -> value end)
  end
end
