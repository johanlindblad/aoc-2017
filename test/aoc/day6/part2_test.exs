defmodule Aoc.Day6.Part2Test do
  use ExUnit.Case
  alias Aoc.Day6.Part2
  doctest Aoc.Day6.Part2

  test "[2 4 1 2] gives 4 steps until repeat" do
    assert Part2.steps_until_repeat([2, 4, 1, 2]) == 4
  end
end

