defmodule DayNineteenTest do
  use ExUnit.Case

  test "returns correct result" do
    input = """
    0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"

    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb
    """

    assert DayNineteen.solve(input) == 2
  end
end
