defmodule DayEight do
  def solve(input) do
    map =
      input
      |> String.split("\n", trim: true)
      |> Stream.with_index(0)
      |> Enum.into(%{}, fn {v, k} -> {k, v} end)

    walk_until_loop(map)
    |> Enum.filter(fn
      x -> Map.fetch!(map, x) |> String.starts_with?("acc")
    end)
    |> Enum.reduce(0, fn
      x, acc ->
        instruction = Map.fetch!(map, x)
        amount = get_arg(instruction)
        acc + amount
    end)
  end

  def walk_until_loop(map, pos \\ 0, visited \\ [])

  def walk_until_loop(map, pos, visited) do
    with {:ok, instruction} <- Map.fetch(map, pos),
         true <- pos not in visited do
      op = get_op(instruction)

      new_pos =
        case op do
          "nop" -> pos + 1
          "acc" -> pos + 1
          "jmp" -> pos + get_arg(instruction)
        end

      walk_until_loop(map, new_pos, [pos | visited])
    else
      # reversing doesn't matter since it's only plus/minus anyway
      _ -> Enum.reverse(visited)
    end
  end

  def get_op(instruction) do
    instruction |> String.split(" ", trim: true) |> Enum.at(0)
  end

  def get_arg(instruction) do
    instruction |> String.split(" ", trim: true) |> Enum.at(1) |> String.to_integer()
  end
end
