defmodule DaySixTest do
  use ExUnit.Case

  test "returns correct count" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert DaySix.solve(input) == 11
    assert DaySix.common_answers(input) == 6
  end
end
