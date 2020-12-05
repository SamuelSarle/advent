defmodule DayThree do
  def solve(input, slope \\ {3, 1}) do
    traverse(input, slope)
  end

  defp traverse(area, {d_x, d_y}) when is_list(area) do
    h = Enum.count(area)
    w = Enum.at(area, 1) |> String.length()

    _traverse(area, w, h, 0, 0, 0, d_x, d_y)
  end

  @doc """
  Traverses through the map, counting the encountered trees.
  If the X axis passes the end, it resets back to the left side,
  otherwise traveling d_x to the right and d_y down.
  When Y passes the end the operation is complete and the accumulator is retured.
  """
  defp _traverse(_, _, height, acc, _, y, _, _) when y > height - 1, do: acc
  defp _traverse(area, width, height, acc, x, y, d_x, d_y) when x > width - 1 do
    _traverse(area, width, height, acc, x - width, y, d_x, d_y)
  end

  defp _traverse(area, width, height, acc, x, y, d_x, d_y) do
    sign =
      area
      |> Enum.at(y)
      |> String.at(x)

    if sign == "#" do
      _traverse(area, width, height, acc + 1, x + d_x, y + d_y, d_x, d_y)
    else
      _traverse(area, width, height, acc, x + d_x, y + d_y, d_x, d_y)
    end
  end
end
