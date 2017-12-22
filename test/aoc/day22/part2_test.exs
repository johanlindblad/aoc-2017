defmodule Aoc.Day22.Part2Test do
  use ExUnit.Case
  alias Aoc.Day22.Part2
  doctest Aoc.Day22.Part2

  @example "..#\n#..\n..."

  @tag :slow
  test "example input gives 2511944" do
    assert Part2.solve(@example, 10000000) == 2511944
  end

  @tag :slow
  test "puzzle input gives 2512017" do
    assert Part2.solve(Aoc.puzzle_input(22), 10000000) == 2512017
  end
end
