defmodule DayEighteenTest do
  use ExUnit.Case

  test "returns correct result" do
    assert DayEighteen.solve("1 + 2 * 3 + 4 * 5 + 6") == 71
    assert DayEighteen.solve("2 * 3 + (4 * 5)") == 26
    assert DayEighteen.solve("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    assert DayEighteen.solve("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
  end
end
