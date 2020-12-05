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

  test "returns missing seat ID" do
    input = [
      "BFFFBFFRLR",
      "BFFFBFFLRR",
      "BFFFBFFLRL"
    ]

    assert DayFive.missing_seat(input) == 548
  end
end
