defmodule DaySixteen do
  def solve(input) do
    input
    |> format_input()
    |> find_invalid_fields()
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  def find_invalid_fields({filters, tickets}) do
    tickets
    |> Enum.concat()
    |> Enum.reject(fn
      x -> MapSet.member?(filters, x)
    end)
  end

  def format_input(input) do
    [filters, [_ | own_ticket], [_ | tickets]] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))

    filters = format_filters(filters)
    tickets = format_tickets([own_ticket | tickets])

    {filters, tickets}
  end

  def format_filters(filt_list) do
    filt_list
    |> Enum.flat_map(fn
      x ->
        Regex.scan(~r/\b(\d+-\d+)\b/, x, capture: :first)
    end)
    |> Enum.concat()
    |> Enum.uniq()
    |> Enum.reduce(MapSet.new(), fn
      x, acc ->
        [min, max] = String.split(x, "-", trim: true) |> Enum.map(&String.to_integer/1)

        for n <- min..max, into: acc, do: n
    end)
  end

  def format_tickets(tick_list) do
    tick_list
    |> Enum.map(fn
      [x] -> x
      x -> x
    end)
    |> Enum.map(fn
      x -> x |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end

  def not_in_filters?(filters, value), do: Enum.any?(fn -> value not in filters end)
end
