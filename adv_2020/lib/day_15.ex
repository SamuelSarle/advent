defmodule DayFifteen do
  def solve(input, opts \\ []) do
    turns = Keyword.get(opts, :turns, 2020)

    input_len =
      input
      |> String.split(",", trim: true)
      |> Enum.count()

    if turns > 0 and turns <= input_len do
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.at(turns - 1)
    else
      table = :ets.new(:history, [:named_table, :ordered_set])

      answer =
        input
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> setup_table_and_params(table)
        |> Stream.iterate(fn
          {elem, cur_turn} ->
            new_elem =
              case :ets.lookup(table, elem) do
                [] ->
                  0

                [{_, last}] ->
                  abs(cur_turn - last)
              end

            :ets.insert(table, {elem, cur_turn})
            {new_elem, cur_turn + 1}
        end)
        |> Enum.at(turns - input_len)
        |> elem(0)

      :ets.delete(table)

      answer
    end
  end

  defp setup_table_and_params(list, table) do
    list
    |> Enum.with_index(1)
    |> Enum.each(fn x -> :ets.insert(table, x) end)

    {Enum.reverse(list) |> Enum.at(0), Enum.count(list)}
  end
end
