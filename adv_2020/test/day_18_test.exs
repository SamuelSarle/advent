defmodule DayEighteenTest do
  use ExUnit.Case

  test "returns correct result" do
    assert DayEighteen.solve("1 + 2 * 3 + 4 * 5 + 6") == 71
    assert DayEighteen.solve("2 * 3 + (4 * 5)") == 26
    assert DayEighteen.solve("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    assert DayEighteen.solve("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
  end

  test "part two returns correct result" do
    assert DayEighteen.PartTwo.solve("1 + 2 * 3 + 4 * 5 + 6") == 231
    assert DayEighteen.PartTwo.solve("2 * 3 + (4 * 5)") == 46
    assert DayEighteen.PartTwo.solve("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
    assert DayEighteen.PartTwo.solve("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
  end
end
