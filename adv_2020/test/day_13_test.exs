defmodule DayThirteenTest do
  use ExUnit.Case

  test "returns correct answer" do
    input = """
    939
    7,13,x,x,59,x,31,19
    """

    assert DayThirteen.solve(input) == 295
  end
end
