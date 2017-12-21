defmodule Aoc.Day21.Part2Test do
  use ExUnit.Case
  alias Aoc.Day21.Part1
  doctest Aoc.Day21.Part1

  @tag :slow
  test "puzzle input gives 2536879" do
    patterns = Part1.parse_transformations(Aoc.puzzle_input(21))
    assert Part1.on_after(patterns, 18) == 2536879
  end
end
