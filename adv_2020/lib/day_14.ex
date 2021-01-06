defmodule DayFourteen do
  def solve(input) do
    input
    |> format_input_to_data()
    |> Enum.flat_map(&apply_operations/1)
    |> Map.new()
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
  end

  def format_input_to_data(input) do
    input
    |> String.split("mask = ", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn
      [mask | instructions] ->
        formatted_ins =
          Enum.map(instructions, fn
            x ->
              %{"addr" => addr, "val" => val} =
                Regex.named_captures(~r/mem\[(?<addr>\d+)\]\s*=\s*(?<val>\d*)/, x)

              {String.to_integer(addr), String.to_integer(val)}
          end)

        {mask, formatted_ins}
    end)
  end

  def apply_operations({mask, ops}) do
    ops
    |> Enum.map(fn
      {addr, val} ->
        {addr, apply_mask(mask, val)}
    end)
  end

  def apply_mask(mask, val) do
    # use len of the mask to convert the value into a matching length
    len = String.length(mask)
    # the answer is also an integer of the same length
    <<n::size(len)>> = _apply_mask(mask, <<val::integer-size(len)>>, <<>>)
    n
  end

  defp _apply_mask(<<>>, <<>>, acc), do: acc

  defp _apply_mask(<<"1", rest_mask::binary>>, <<_::1, rest_val::bitstring>>, acc) do
    _apply_mask(rest_mask, rest_val, <<acc::bitstring, 1::1>>)
  end

  defp _apply_mask(<<"0", rest_mask::binary>>, <<_::1, rest_val::bitstring>>, acc) do
    _apply_mask(rest_mask, rest_val, <<acc::bitstring, 0::1>>)
  end

  defp _apply_mask(<<"X", rest_mask::binary>>, <<n::1, rest_val::bitstring>>, acc) do
    _apply_mask(rest_mask, rest_val, <<acc::bitstring, n::1>>)
  end
end
