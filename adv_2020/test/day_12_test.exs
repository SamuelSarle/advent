defmodule DayTwelveTest do
  use ExUnit.Case, async: true

  test "returns correct answer" do
    input = """
    F10
    N3
    F7
    R90
    F11
    """

    assert DayTwelve.solve(input) == 25
  end
end
