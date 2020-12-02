defmodule DayOneTest do
  use ExUnit.Case

  test "no input returns nil" do
    assert DayOne.solve([]) == nil
  end

  test "valid input returns the correct result" do
    assert DayOne.solve([1721, 979, 366, 299, 675, 1456]) == 514_579
  end

  test "input with no matching pairs returns nil" do
    assert DayOne.solve([1721, 979, 366, 675, 1456]) == nil
  end

  test "3-dimensional returns correct answer" do
    assert DayOne.solve([1721, 979, 366, 299, 675, 1456], 3) == 241_861_950
  end
end
