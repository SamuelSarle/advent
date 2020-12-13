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

  def transform_to_map(input) when is_binary(input) do
    [item, subitems] = String.split(input, " contain", trim: true)

    item = String.replace_trailing(item, " bags", "")
    subitems = get_subitems(subitems)

    {item, subitems}
  end

  def has_subitem?(map, candidate, target) do
    with {:ok, subitems} <- Map.fetch(map, candidate) do
      cond do
        target in subitems -> true
        Enum.any?(subitems, &has_subitem?(map, &1, target)) -> true
        true -> false
      end
    else
      _ -> false
    end
  end

  def get_subitems(input) when is_binary(input) do
    Regex.scan(~r/ \d* ([\w\s]*) bags?/, input, capture: :all_but_first)
    |> Enum.concat()
  end
end
