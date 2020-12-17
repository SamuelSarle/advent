defmodule DayNine do
  def solve(input, opts \\ []) do
    preamble = Keyword.get(opts, :preamble, 25)

    input
    |> String.split("\n", trim: true)
    |> Stream.map(&String.to_integer(&1))
    |> Enum.reverse()
    |> Stream.chunk_every(preamble + 1, 1)
    |> Enum.reduce_while(0, fn
      [head | rest], _ ->
        case two_sum_exists?(rest, head) do
          false -> {:halt, head}
          true -> {:cont, 0}
        end
    end)
  end

  # Adapted from https://rosettacode.org/wiki/Two_sum#Elixir
  defp two_sum_exists?(list, sum) do
    list
    |> Enum.reduce_while(false, fn x, _ ->
      y = sum - x

      case Enum.any?(list, &(&1 == y)) do
        false -> {:cont, false}
        true -> {:halt, true}
      end
    end)
  end
end
