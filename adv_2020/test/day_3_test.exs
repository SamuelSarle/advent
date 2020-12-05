defmodule DayThreeTest do
  use ExUnit.Case

  test "returns correct count" do
    input = [
      "..##.......",
      "#...#...#..",
      ".#....#..#.",
      "..#.#...#.#",
      ".#...##..#.",
      "..#.##.....",
      ".#.#.#....#",
      ".#........#",
      "#.##...#...",
      "#...##....#",
      ".#..#...#.#"
    ]

    assert DayThree.solve(input) == 7
    assert DayThree.solve(input, {1,1}) == 2
    assert DayThree.solve(input, {5,1}) == 3
    assert DayThree.solve(input, {7,1}) == 4
    assert DayThree.solve(input, {1,2}) == 2
  end
end
