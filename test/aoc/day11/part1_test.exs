defmodule Aoc.Day11.Part2Test do
  use ExUnit.Case
  alias Aoc.Day11.Part2
  doctest Aoc.Day11.Part2

  test "puzzle input gives 1596" do
    assert Part2.solve(Aoc.puzzle_input(11)) == 1596
  end
end
