defmodule DayNineTest do
  use ExUnit.Case

  test "returns correct answer" do
    input = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert DayNine.solve(input, preamble: 5) == 127
  end


  test "part two returns correct answer" do
    input = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert DayNine.PartTwo.solve(input, preamble: 5) == 62
  end
end
