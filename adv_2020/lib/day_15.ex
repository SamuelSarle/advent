defmodule DayFifteen do
  def solve(input, opts \\ []) do
    turns = Keyword.get(opts, :turns, 2020)

    input_len =
      input
      |> String.split(",", trim: true)
      |> Enum.count()

    if turns > 0 and turns <= input_len do
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.at(turns - 1)
    else
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Stream.iterate(fn
        [head | tail] ->
          new =
            tail
            |> Stream.with_index(1)
            |> Stream.filter(fn {val, _} -> val == head end)
            |> Stream.map(fn {_, i} -> i end)
            |> Enum.at(0, 0)

          [new, head | tail]
      end)
      |> Enum.at(turns - input_len)
      |> Enum.at(0)
    end
  end
end
