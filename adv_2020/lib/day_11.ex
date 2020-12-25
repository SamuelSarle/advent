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

  def solve(input) do
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
    |> step_until_stable()
    # |> pretty_print()
    |> count_occupied()
  end

  defp step_until_stable(map, last \\ %{})
  defp step_until_stable(map, last) when map === last, do: map

  defp step_until_stable(map, _) do
    map
    |> step()
    |> step_until_stable(map)
  end

  defp step(map) do
    map
    |> Enum.map(fn
      {pos, type} ->
        new_type = updated_type(type, get_neigbours_count(map, pos))

        {pos, new_type}
    end)
    |> Map.new()
  end

  defp pretty_print(map) do
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
      {pos, type} ->
        sym = get_sym(type)

        case pos do
          {0, _} -> "\n" <> sym
          _ -> sym
        end
    end)
    |> Enum.join("")
    |> IO.puts()

    map
  end

  defp updated_type(:empty, neighbours_count) when neighbours_count == 0, do: :occupied
  defp updated_type(:occupied, neighbours_count) when neighbours_count >= 4, do: :empty
  defp updated_type(type, _), do: type

  defp count_occupied(map) do
    map
    |> Enum.reduce(0, fn
      {_, type}, acc ->
        case type do
          :occupied -> acc + 1
          _ -> acc
        end
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

  defp get_type("L"), do: :empty
  defp get_type("#"), do: :occupied
  defp get_type("."), do: :floor

  # which is more idiomatic?

  defp get_sym(type) do
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
