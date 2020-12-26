defmodule DayEleven do
  @neighbours [
    # three at the top
    {-1, -1},
    {0, -1},
    {1, -1},
    # two in the middle
    {-1, 0},
    {1, 0},
    # three at the bottom
    {-1, 1},
    {0, 1},
    {1, 1}
  ]
  @max_count 4

  def solve(input) do
    input
    |> build_map()
    |> step_until_stable()
    # |> pretty_print()
    |> count_occupied()
  end

  def build_map(input) do
    input
    |> String.split("", trim: true)
    |> Enum.reduce({[], 0, 0}, fn
      "\n", {list, _x, y} ->
        {list, 0, y + 1}

      val, {list, x, y} ->
        {[{{x, y}, get_type(val)} | list], x + 1, y}
    end)
    |> elem(0)
    |> Map.new()
  end

  def step_until_stable(map), do: step_until_stable(map, %{})
  defp step_until_stable(map, last) when map === last, do: map

  defp step_until_stable(map, _) do
    map
    |> step()
    |> step_until_stable(map)
  end

  def step(map) do
    map
    |> Enum.map(fn
      {pos, type} ->
        new_type = updated_type(type, get_neigbours_count(map, pos), @max_count)

        {pos, new_type}
    end)
    |> Map.new()
  end

  def pretty_print(map) do
    sorter = fn
      {ax, ay}, {bx, by} ->
        cond do
          ay < by -> true
          ay == by && ax < bx -> true
          true -> false
        end
    end

    map
    |> Enum.sort_by(fn {pos, _} -> pos end, sorter)
    |> Enum.map(fn
      {{0, _}, type} -> "\n" <> get_sym(type)
      {_, type} -> get_sym(type)
    end)
    |> Enum.join("")
    |> IO.puts()

    map
  end

  def updated_type(:empty, neighbours_count, _) when neighbours_count == 0,
    do: :occupied

  def updated_type(:occupied, neighbours_count, max_count) when neighbours_count >= max_count,
    do: :empty

  def updated_type(type, _, _), do: type

  def count_occupied(map) do
    map
    |> Enum.reduce(0, fn
      {_, :occupied}, acc -> acc + 1
      {_, _}, acc -> acc
    end)
  end

  defp get_neigbours_count(map, pos) do
    neighbours = pos |> neighbours()

    map
    |> Enum.filter(fn
      {pos, _} -> pos in neighbours
    end)
    |> count_occupied()
  end

  def get_type("L"), do: :empty
  def get_type("#"), do: :occupied
  def get_type("."), do: :floor

  # which is more idiomatic?

  def get_sym(type) do
    case type do
      :floor -> "."
      :occupied -> "#"
      :empty -> "L"
    end
  end

  defp neighbours({x, y}) do
    @neighbours
    |> Enum.map(fn
      {dx, dy} -> {x + dx, y + dy}
    end)
  end
end

defmodule DayEleven.PartTwo do
  import DayEleven, except: [get_neigbours_count: 2, step_until_stable: 1, step: 1]

  @neighbour_dirs [
    # three at the top
    {-1, -1},
    {0, -1},
    {1, -1},
    # two in the middle
    {-1, 0},
    {1, 0},
    # three at the bottom
    {-1, 1},
    {0, 1},
    {1, 1}
  ]
  @max_count 5

  def solve(input) do
    input
    |> build_map()
    |> step_until_stable()
    # |> pretty_print()
    |> count_occupied()
  end

  def step_until_stable(map), do: step_until_stable(map, %{})
  defp step_until_stable(map, last) when map === last, do: map

  defp step_until_stable(map, _) do
    map
    |> step()
    |> step_until_stable(map)
  end

  def step(map) do
    map
    |> Enum.map(fn
      {pos, type} ->
        new_type = updated_type(type, get_neigbours_count(map, pos), @max_count)

        {pos, new_type}
    end)
    |> Map.new()
  end

  def get_neigbours_count(map, pos) do
    @neighbour_dirs
    |> Enum.map(fn
      dir ->
        walk_until_seat(dir, map, pos)
    end)
    |> Enum.reduce(0, fn
      :occupied, acc -> acc + 1
      _, acc -> acc
    end)
  end

  def walk_until_seat(dir = {dx, dy}, map, {x, y}) do
    target_pos = {x + dx, y + dy}

    case Map.get(map, target_pos, :empty) do
      :empty -> :empty
      :occupied -> :occupied
      :floor -> walk_until_seat(dir, map, target_pos)
    end
  end
end
