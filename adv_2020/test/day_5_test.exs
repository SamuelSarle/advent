defmodule DayFiveTest do
  use ExUnit.Case

  test "returns correct seat ID" do
    assert DayFive.solve(["FBFBBFFRLR"]) == 357
  end

  test "returns highest seat ID" do
    input = [
      "FBFBBFFRLR",
      "BFFFBBFRRR",
      "FFFBBBFRRR",
      "BBFFBBFRLL"
    ]

    assert DayFive.solve(input) == 820
  end
end
