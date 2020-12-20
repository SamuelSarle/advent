defmodule DayTen do
  def solve(input) do
    {_, ones, threes} =
      input
      |> String.split("\n", trim: true)
      |> Stream.map(&String.to_integer/1)
      |> Enum.sort()
      |> Enum.reduce({0, 1, 1}, fn
        x, {last, ones, threes} ->
          cond do
            last == 0 -> {x, ones, threes}
            x - last == 1 -> {x, ones + 1, threes}
            x - last == 3 -> {x, ones, threes + 1}
            true -> {x, ones, threes}
          end
      end)

    ones * threes
  end
end
