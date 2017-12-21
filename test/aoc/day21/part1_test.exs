defmodule Aoc.Day21.Part1Test do
  use ExUnit.Case
  alias Aoc.Day21.Part1
  doctest Aoc.Day21.Part1

  @example "../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#"

  test "example gives 12 on after 2 iterations" do
    patterns = Part1.parse_transformations(@example)
    assert Part1.on_after(patterns, 2) == 12
  end

  test "puzzle input gives 194" do
    patterns = Part1.parse_transformations(Aoc.puzzle_input(21))
    assert Part1.on_after(patterns, 5) == 194
  end
end
