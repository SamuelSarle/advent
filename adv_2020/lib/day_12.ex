defmodule DayTwelve do
  def solve(input) do
    {_, dx, dy} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        x ->
          [cmd, c] = String.split(x, "", trim: true, parts: 2)
          c = String.to_integer(c)

          case cmd do
            "R" -> {:turn, "R", c}
            "L" -> {:turn, "L", c}
            _ -> {:move, cmd, c}
          end
      end)
      |> Enum.reduce({:east, 0, 0}, fn
        {:turn, way, amount}, {facing_dir, x, y} ->
          {turn(facing_dir, amount, way), x, y}

        {:move, way, amount}, {facing_dir, x, y} ->
          {dx, dy} = move(way, amount, facing_dir)
          {facing_dir, x + dx, y + dy}
      end)

    abs(dx) + abs(dy)
  end

  defp move("F", amount, :east), do: move("E", amount)
  defp move("F", amount, :west), do: move("W", amount)
  defp move("F", amount, :north), do: move("N", amount)
  defp move("F", amount, :south), do: move("S", amount)

  defp move(way, amount, _), do: move(way, amount)

  defp move("E", amount), do: {amount, 0}
  defp move("W", amount), do: {-amount, 0}
  defp move("N", amount), do: {0, amount}
  defp move("S", amount), do: {0, -amount}

  defp turn(dir, deg, way) when deg > 90 do
    turn(dir, 90, way)
    |> turn(deg - 90, way)
  end

  defp turn(:east, 90, "R"), do: :south
  defp turn(:south, 90, "R"), do: :west
  defp turn(:west, 90, "R"), do: :north
  defp turn(:north, 90, "R"), do: :east

  defp turn(:east, 90, "L"), do: :north
  defp turn(:south, 90, "L"), do: :east
  defp turn(:west, 90, "L"), do: :south
  defp turn(:north, 90, "L"), do: :west
end
