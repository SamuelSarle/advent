defmodule DayFifteenTest do
  use ExUnit.Case

  test "returns correct answer" do
    assert DayFifteen.solve("0,3,6", turns: 1) == 0
    assert DayFifteen.solve("0,3,6", turns: 2) == 3
    assert DayFifteen.solve("0,3,6", turns: 3) == 6
    assert DayFifteen.solve("0,3,6", turns: 4) == 0
    assert DayFifteen.solve("0,3,6", turns: 5) == 3
    assert DayFifteen.solve("0,3,6", turns: 6) == 3
    assert DayFifteen.solve("1,3,2", turns: 2020) == 1
    assert DayFifteen.solve("2,1,3", turns: 2020) == 10
    assert DayFifteen.solve("1,2,3", turns: 2020) == 27
  end
end
