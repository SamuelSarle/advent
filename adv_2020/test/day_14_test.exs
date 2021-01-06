defmodule DayFourteenTest do
  use ExUnit.Case

  test "returns correct answer" do
    input = """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """

    assert DayFourteen.solve(input) == 165
  end
end
