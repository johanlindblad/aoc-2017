defmodule Aoc.Day19.Part1Test do
  use ExUnit.Case
  alias Aoc.Day19.Part1
  doctest Aoc.Day19.Part1

  @example "     |          \n     |  +--+    \n     A  |  C    \n F---|----E|--+ \n     |  |  |  D \n     +B-+  +--+ \n"

  test "example gives start at 5,0" do
    assert Part1.parse(@example) |> Part1.start_index == {5,0}
  end

  test "example gives ABCDEF" do
    assert Part1.parse(@example) |> Part1.collected == "ABCDEF"
  end

  test "puzzle input gives SXWAIBUZY" do
    assert Part1.parse(Aoc.puzzle_input(19)) |> Part1.collected == "SXWAIBUZY"
  end
end

