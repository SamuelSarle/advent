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

  defmodule PartTwo do
    def solve(input, opts \\ []) do
      target = DayNine.solve(input, opts)

      input =
        input
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer(&1))

      find_matching_seq(input, target)
    end

    defp find_matching_seq(data, target) do
      _find_matching_seq(data, target, Enum.count(data), 2)
    end

    defp _find_matching_seq(_, _, data_len, len) when len >= data_len, do: nil

    # chunks the input according to len, if a chunk with sum of target exists, returns it
    defp _find_matching_seq(data, target, data_len, len) do
      case data
           |> Stream.chunk_every(len, 1, :discard)
           # check that each element is less than target
           |> Stream.filter(fn x -> x |> Enum.all?(&(&1 < target)) end)
           |> Enum.reduce_while([], fn
             chunk, _ ->
               if chunk |> Enum.sum() == target do
                 {:halt, chunk}
               else
                 {:cont, []}
               end
           end)
           |> Enum.min_max(fn -> {nil, nil} end) do
        {nil, nil} -> _find_matching_seq(data, target, data_len, len + 1)
        {min, max} -> min + max
      end
    end
  end
end
