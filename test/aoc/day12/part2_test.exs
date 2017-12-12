defmodule Aoc.Day12.Part2Test do
  use ExUnit.Case
  alias Aoc.Day12.Part2
  doctest Aoc.Day12.Part2

  @example "0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"

  test "example input gives 2" do
    assert Part2.solve(@example) == 2
  end

  test "puzzle input gives 193" do
    assert Part2.solve(Aoc.puzzle_input(12)) == 193
  end
end

