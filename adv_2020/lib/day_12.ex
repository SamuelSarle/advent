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

  def move("E", amount), do: {amount, 0}
  def move("W", amount), do: {-amount, 0}
  def move("N", amount), do: {0, amount}
  def move("S", amount), do: {0, -amount}

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

defmodule DayTwelve.PartTwo do
  import DayTwelve, only: [move: 2]

  def solve(input) do
    {{x, y}, _} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        x ->
          [cmd, c] = String.split(x, "", trim: true, parts: 2)
          c = String.to_integer(c)

          case cmd do
            "R" -> {:turn, "R", c}
            "L" -> {:turn, "L", c}
            "F" -> {:move_to_waypoint, cmd, c}
            _ -> {:move_waypoint, cmd, c}
          end
      end)
      |> Enum.reduce({{0, 0}, {10, 1}}, fn
        {:move_to_waypoint, _, c}, {{x, y}, waypoint = {dx, dy}} ->
          new_loc = {x + dx * c, y + dy * c}
          {new_loc, waypoint}

        {:move_waypoint, cmd, c}, {loc, {x, y}} ->
          {dx, dy} = move(cmd, c)
          new_waypoint = {x + dx, y + dy}
          {loc, new_waypoint}

        {:turn, cmd, c}, {loc, waypoint} ->
          new_waypoint = turn_waypoint(waypoint, c, cmd)
          {loc, new_waypoint}
      end)

    abs(x) + abs(y)
  end

  def turn_waypoint(waypoint, deg, way) when deg > 90 do
    turn_waypoint(waypoint, 90, way)
    |> turn_waypoint(deg - 90, way)
  end

  def turn_waypoint({x, y}, 90, "L"), do: {-y, x}
  def turn_waypoint({x, y}, 90, "R"), do: {y, -x}
end
