defmodule DayOne do
  @target 2020

  @doc """
  Finds (dimensions) amount of elements that have a sum matching @target, returns their product.
  Runs in O(n^dimensions)
  """
  def solve(list, dimensions \\ 2)
  def solve([], _), do: nil

  def solve(list, dimensions) do
    case comb(dimensions, list)
         |> Stream.filter(&(Enum.sum(&1) == @target))
         |> Enum.take(1)
         |> Enum.concat() do
      [] -> nil
      items -> Enum.reduce(items, 1, fn x, acc -> x * acc end)
    end
  end

  @doc """
  Creates all combinations of list elements, from https://rosettacode.org/wiki/Combinations#Elixir
  """
  defp comb(0, _), do: [[]]
  defp comb(_, []), do: []

  defp comb(m, [h | t]) do
    for(l <- comb(m - 1, t), do: [h | l]) ++ comb(m, t)
  end
end
