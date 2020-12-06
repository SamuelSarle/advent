defmodule DaySix do
  def solve(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Stream.map(&unique_answers/1)
    |> Enum.sum()
  end

  defp unique_answers(input) do
    Regex.scan(~r/[a-zA-Z]/, input)
    |> Enum.concat()
    |> Stream.uniq()
    |> Enum.count()
  end
end
