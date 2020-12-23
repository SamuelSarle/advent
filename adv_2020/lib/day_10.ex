defmodule DayTen do
  def solve(input) do
    {_, ones, threes} =
      input
      |> String.split("\n", trim: true)
      |> Stream.map(&String.to_integer/1)
      |> Enum.sort()
      |> Enum.reduce({0, 1, 1}, fn
        x, {last, ones, threes} ->
          cond do
            last == 0 -> {x, ones, threes}
            x - last == 1 -> {x, ones + 1, threes}
            x - last == 3 -> {x, ones, threes + 1}
            true -> {x, ones, threes}
          end
      end)

    ones * threes
  end

  defmodule PartTwo do
    def solve(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.into(%{}, fn x -> {x, []} end)
      |> add_paths()
      |> count_paths()
    end

    defp add_paths(%{} = map) do
      map
      |> Enum.map(fn
        {k, paths} ->
          # find any points up to +3 from here, add them to own list
          new_paths =
            paths ++
              Enum.reduce(1..3, [], fn
                x, acc ->
                  with {:ok, _} <- Map.fetch(map, k + x) do
                    [k + x | acc]
                  else
                    _ -> acc
                  end
              end)

          {k, Enum.uniq(new_paths)}
      end)
      |> Enum.into(%{}, fn {k, paths} -> {k, paths} end)
    end

    defp count_paths(map) do
      map
      |> Enum.filter(fn {k, _} -> k <= 3 end)
      |> Enum.map(fn {k, _} -> k end)
      |> Enum.reduce(0, fn
        k, acc ->
          {count, _} = get_or_calc_count(map, k)
          acc + count
      end)
    end

    defp get_or_calc_count(map, k, cache \\ %{}) do
      with {count, new_cache} <- get_cached_count(cache, k) || calculate_count(map, k, cache) do
        new_cache = add_count_to_cache(new_cache, k, count)
        {count, new_cache}
      end
    end

    defp get_cached_count(cache, k) do
      with {:ok, c} <- Map.fetch(cache, k) do
        {c, cache}
      else
        _ -> nil
      end
    end

    defp calculate_count(map, k, cache) do
      with {:ok, paths} <- get_subpaths(map, k) do
        paths
        |> Enum.reduce({0, cache}, fn
          x, {acc, new_cache} ->
            {count, new_cache} = get_or_calc_count(map, x, new_cache)
            {acc + count, new_cache}
        end)
      else
        # no subpaths, it's the last one, return 1
        _ -> {1, cache}
      end
    end

    defp add_count_to_cache(cache, k, count) do
      Map.put(cache, k, count)
    end

    defp get_subpaths(map, k) do
      with {:ok, paths} <- Map.fetch(map, k),
           true <- Enum.count(paths) > 0 do
        {:ok, paths}
      end
    end
  end
end
