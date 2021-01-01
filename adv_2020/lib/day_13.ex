defmodule DayThirteen do
  def solve(input) do
    {bus_id, wait_dur} =
      input
      |> String.split("\n", trim: true)
      |> format_input()
      |> earliest_bus()

    bus_id * wait_dur
  end

  def format_input([target, busses]) do
    busses =
      busses
      |> String.split([",", "x"], trim: true)
      |> Enum.map(&String.to_integer(&1))

    {String.to_integer(target), busses}
  end

  def earliest_bus({target, busses}) do
    busses
    |> Enum.map(fn
      id ->
        wait_dur = id - rem(target, id)
        {id, wait_dur}
    end)
    |> Enum.min_by(fn {_, wait} -> wait end)
  end
end
