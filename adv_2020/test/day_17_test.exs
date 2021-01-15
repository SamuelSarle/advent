defmodule DaySeventeenTest do
  use ExUnit.Case

  import DaySeventeen

  test "returns correct answer" do
    input = """
    .#.
    ..#
    ###
    """

    assert format_input(input) |> step(1) |> count_active() == 11
    assert solve(input) == 112
  end

  test "counting active returns correct result" do
    input = """
    .#.
    ..#
    ###
    """

    assert format_input(input) |> count_active() == 5
  end
end
