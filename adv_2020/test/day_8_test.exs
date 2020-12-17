defmodule DayEightTest do
  use ExUnit.Case

  test "returns correct output" do
    input = """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """

    assert DayEight.solve(input) == 5
  end
end
