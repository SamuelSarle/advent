defmodule DaySeven do
  def solve(input) do
    item_map =
      input
      |> String.split("\n", trim: true)
      |> Map.new(&transform_to_map/1)

    item_map
    |> Enum.count(fn
      {k, _} ->
        has_subitem?(item_map, k, "shiny gold")
    end)
  end

  defp has_subitem?(map, candidate, target) do
    with {:ok, subitems} <- Map.fetch(map, candidate),
         true <- target in subitems || Enum.any?(subitems, &has_subitem?(map, &1, target)) do
      true
    else
      _ -> false
    end
  end

  defp transform_to_map(input) when is_binary(input) do
    [item, subitems] = String.split(input, " contain", trim: true)

    item = String.replace_trailing(item, " bags", "")
    subitems = get_subitems(subitems)

    {item, subitems}
  end

  defp get_subitems(input) when is_binary(input) do
    Regex.scan(~r/ \d* ([\w\s]*) bags?/, input, capture: :all_but_first)
    |> Enum.concat()
  end

  defmodule PartTwo do
    def solve(input) do
      item_map =
        input
        |> String.split("\n", trim: true)
        |> Map.new(&transform_to_map/1)

      # -1 since the main bag doesn't count
      count_subitems(item_map, "shiny gold") - 1
    end

    defp count_subitems(map, target) do
      with {:ok, subitems} <- Map.fetch(map, target) do
        _count_subitems(map, subitems)
      end
    end

    defp _count_subitems(_, []), do: 0

    defp _count_subitems(_, [{0, nil}]), do: 1

    defp _count_subitems(map, items) do
      items
      # start at 1 for the bag itself
      |> Enum.reduce(1, fn
        {count, subitem}, acc ->
          # recurse over subitems
          with {:ok, subitems} <- Map.fetch(map, subitem) do
            acc + count * _count_subitems(map, subitems)
          end
      end)
    end

    defp transform_to_map(input) when is_binary(input) do
      [item, subitems] = String.split(input, " contain", trim: true)

      item = String.replace_trailing(item, " bags", "")
      subitems = get_subitems(subitems)

      {item, subitems}
    end

    defp get_subitems(input) when is_binary(input) do
      # capture count and name of bags
      Regex.scan(~r/ (\d+|no) ([\w\s]*) bags?/, input, capture: :all_but_first)
      |> Enum.map(fn
        # "contain no bags"
        ["no", _] -> {0, nil}
        # "contain 2 dark red bags, ..."
        [x, item] -> {String.to_integer(x), item}
      end)
    end
  end
end
