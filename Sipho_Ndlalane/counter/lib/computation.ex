defmodule Computation do
  def double(numbers) do
    numbers
    |> Enum.map(fn num ->
      Task.async(fn -> num * 2 end)
    end)
    |> Enum.map(&Task.await/1)
  end
end
