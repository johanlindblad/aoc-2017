defmodule Aoc.Day19.Part2Test do
  use ExUnit.Case
  alias Aoc.Day19.Part1
  alias Aoc.Day19.Part2
  doctest Aoc.Day19.Part2

  @example "     |          \n     |  +--+    \n     A  |  C    \n F---|----E|--+ \n     |  |  |  D \n     +B-+  +--+ \n"

  test "example gives 38" do
    assert Part1.parse(@example) |> Part1.walk_stream |> Part2.num_steps == 38
  end

  test "puzzle input gives 16676" do
    assert Part1.parse(Aoc.puzzle_input(19)) |> Part1.walk_stream |> Part2.num_steps == 16676
  end
end

