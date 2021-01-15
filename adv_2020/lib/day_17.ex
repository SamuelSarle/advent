defmodule DaySeventeen do
  def solve(input, opts \\ []) do
    cycles = Keyword.get(opts, :cycles, 6)

    input
    |> format_input()
    |> step(cycles)
    |> count_active()
  end

  def format_input(input) do
    input
    |> String.split("", trim: true)
    |> build_map()
  end

  def build_map(input) do
    input
    |> Enum.reduce({[], {0, 0}}, fn
      "\n", {acc, {_, y}} -> {acc, {0, y + 1}}
      c, {acc, {x, y}} -> {[{{x, y, 0}, c} | acc], {x + 1, y}}
    end)
    |> elem(0)
    |> Map.new()
  end

  def step(state, 0), do: state

  def step(state, cycles) do
    neighbour_counts =
      state
      |> Map.keys()
      |> Enum.reduce(%{}, fn
        pos, acc ->
          sym = Map.get(state, pos)
          add_to_neighbours(acc, pos, sym)
      end)

    new_state =
      neighbour_counts
      |> Enum.filter(fn {_, x} -> x == 2 or x == 3 end)
      |> Enum.map(fn
        {pos, count} ->
          new_sym = Map.get(state, pos) |> updated_sym(count)
          {pos, new_sym}
      end)
      |> Map.new()

    step(new_state, cycles - 1)
  end

  def updated_sym(old_sym, count)
  def updated_sym("#", 2), do: "#"
  def updated_sym(_, 3), do: "#"
  def updated_sym(_, _), do: "."

  def add_to_neighbours(map, pos = {_, _, _}, "#") do
    neighbours = pos |> neighbours()

    neighbours
    |> Enum.reduce(map, fn
      pos, acc -> Map.update(acc, pos, 1, fn n -> n + 1 end)
    end)
  end

  def add_to_neighbours(map, _, "."), do: map

  def count_active_neighbours(map, pos) do
    neighbours = pos |> neighbours()

    map
    |> Enum.filter(fn {pos, _} -> pos in neighbours end)
    |> count_active()
  end

  def neighbours({x, y, z}) do
    still? = fn
      0, 0, 0 -> true
      _, _, _ -> false
    end

    for dx <- -1..1,
        dy <- -1..1,
        dz <- -1..1,
        not still?.(dx, dy, dz),
        do: {x + dx, y + dy, z + dz}
  end

  def count_active(map) do
    map
    |> Map.values()
    |> Enum.filter(fn x -> x == "#" end)
    |> Enum.count()
  end
end
