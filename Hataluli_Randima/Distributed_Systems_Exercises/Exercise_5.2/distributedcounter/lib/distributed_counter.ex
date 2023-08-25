defmodule DistributedCounter do
  use GenServer


  # Client API
  def start_link(initial_count \\ 0) do
    GenServer.start_link(__MODULE__, initial_count, name: __MODULE__)
  end

  def init(init_arg) do
  {:ok, init_arg}
  end

def increment() do
  GenServer.call(DistributedCounter, :increment)
end

def value() do
  GenServer.call(DistributedCounter, :value)
end

# Server Callbacks
def handle_call(:increment, _from, count) do
  IO.puts count
  {:reply, count, count + 1}
end

def handle_call(:value, _from, count) do
  {:reply, count, count}
end

end
