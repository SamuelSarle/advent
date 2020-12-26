defmodule DayElevenTest do
  use ExUnit.Case

  test "returns correct answer" do
    input = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    assert DayEleven.solve(input) == 37
    assert DayEleven.PartTwo.solve(input) == 26
  end
end
