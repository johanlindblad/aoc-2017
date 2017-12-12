defmodule Aoc.Day12.Part1Test do
  use ExUnit.Case
  alias Aoc.Day12.Part1
  doctest Aoc.Day12.Part1

  @example "0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"

  test "example input gives 6" do
    assert Part1.solve(@example) == 6
  end

  test "puzzle input gives 134" do
    assert Part1.solve(Aoc.puzzle_input(12)) == 134
  end
end

