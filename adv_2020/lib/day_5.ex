defmodule DayFive do
  @doc """
  Returns highest seat ID from the input.
  """
  def solve(input) do
    input
    |> Stream.map(&seat_id/1)
    |> Enum.max()
  end

  @doc """
  Loops over sorted seat IDs until one is skipped, returns the skipped ID.
  """
  def missing_seat(input) do
    input
    |> Stream.map(&seat_id/1)
    |> Enum.sort()
    |> Enum.reduce_while(0, fn
      x, acc when acc == x - 2 ->
        {:halt, x - 1}

      x, _ ->
        {:cont, x}
    end)
  end

  defp seat_id(x) when is_binary(x) do
    %{"row" => row, "col" => col} = Regex.named_captures(~r/^(?<row>[BF]{7})(?<col>[LR]{3})$/, x)

    _seat_id(
      seat_row(row),
      seat_col(col)
    )
  end

  defp _seat_id(row, col) when is_integer(row) and is_integer(col), do: row * 8 + col

  defp seat_row(input) do
    <<n::size(7)>> = _seat_row(<<>>, input)
    n
  end

  defp _seat_row(acc, <<>>), do: acc

  defp _seat_row(acc, <<x, rest::binary>>) when is_bitstring(acc) do
    cond do
      <<x>> == "B" -> _seat_row(<<acc::bitstring, 1::1>>, rest)
      <<x>> == "F" -> _seat_row(<<acc::bitstring, 0::1>>, rest)
    end
  end

  defp seat_col(input) do
    <<n::size(3)>> = _seat_col(<<>>, input)
    n
  end

  defp _seat_col(acc, <<>>), do: acc

  defp _seat_col(acc, <<x, rest::binary>>) when is_bitstring(acc) do
    cond do
      <<x>> == "R" -> _seat_col(<<acc::bitstring, 1::1>>, rest)
      <<x>> == "L" -> _seat_col(<<acc::bitstring, 0::1>>, rest)
    end
  end
end
