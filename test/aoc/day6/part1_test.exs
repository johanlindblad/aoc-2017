defmodule Aoc.Day6.Part1Test do
  use ExUnit.Case
  alias Aoc.Day6.Part1
  doctest Aoc.Day6.Part1

  test "[0 2 7 0] gives 5 steps until repeat" do
    assert Part1.steps_until_repeat([0, 2, 7, 0]) == 5
  end

  test "step with [0 2 7 0] gives [2 4 1 2]" do
    assert Part1.step([0, 2, 7, 0]) == [2, 4, 1, 2]
  end

  test "step with [0 1 2 5] gives [2 2 3 1]" do
    assert Part1.step([0, 1, 2, 5]) == [2, 2, 3, 1]
  end

  test "step with [10 3 15 10 5 15 5 15 9 2 5 8 5 2 3 6] gives [11 4 1 11 6 16 6 16 10 3 6 9 6 3 4 7]" do
    before = [10, 3, 15, 10, 5, 15, 5, 15, 9, 2, 5, 8, 5, 2, 3, 6]
    result = [11, 4, 0, 11, 6, 16, 6, 16, 10, 3, 6, 9, 6, 3, 4, 7]
    assert Part1.step(before) == result
  end
end

