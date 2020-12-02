defmodule DayTwoTest do
  use ExUnit.Case

  test "valid input returns correct answer" do
    input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
    assert DayTwo.solve(input) == 2
  end

  # getting correct parameters is already tested above
  test "valid input returns the correct parameters" do
    assert DayTwo.interpret_params("1-3 a: abcde") == {1, 3, "a", "abcde"}
  end

  test "invalid input params returns an error" do
    assert DayTwo.interpret_params("1-2") == :error
    assert DayTwo.interpret_params("1-2 a:") == :error
    assert DayTwo.interpret_params("1 a: a") == :error
    assert DayTwo.interpret_params("1-2 a: a") != :error
  end

  defmodule PartTwo do
    use ExUnit.Case

    test "non-valid password returns count of 0" do
      input = ["6-8 s: svsssszslpsp"]
      assert DayTwo.PartTwo.solve(input) == 0
    end

    test "valid input returns correct answer" do
      input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc", "6-8 s: svsssszslpsp"]
      assert DayTwo.PartTwo.solve(input) == 1
    end
  end
end
