defmodule Aoc.Day6.Part2Test do
  use ExUnit.Case
  alias Aoc.Day6.Part2
  doctest Aoc.Day6.Part2

  test "[2 4 1 2] gives a cycle length of 4" do
    assert Part2.cycle_length([2, 4, 1, 2]) == 4
  end
end

