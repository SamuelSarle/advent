defmodule DayFive do
  def solve(input) do
    input
    |> Stream.map(fn
      x ->
        %{"row" => row, "col" => col} = Regex.named_captures(~r/^(?<row>[BF]{7})(?<col>[LR]{3})$/, x)
        seat_id(
          seat_row(row),
          seat_col(col)
        )
    end)
    |> Enum.max()
  end

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


  defp seat_id(row, col) when is_integer(row) and is_integer(col), do: row * 8 + col
end
