defmodule CounterTest do
  def test(counter_module, num_processes, num_operations) do
    counter_module.start_link()
    1..num_processes
    |> Enum.map(fn _ ->
      spawn(fn ->
        1..num_operations |> Enum.each(fn _ -> counter_module.increment() end)
        IO.puts("Final counter value: #{counter_module.get()}")
      end)
    end)
    #|> Enum.each(&Process.join/1)
  end
end
