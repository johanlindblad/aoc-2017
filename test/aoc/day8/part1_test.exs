defmodule Aoc.Day8.Part1Test do
  use ExUnit.Case
  alias Aoc.Day8.Part1
  doctest Aoc.Day8.Part1
  @example "b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"

  test "simulation gives 1 for example input" do
    val = Part1.parse(@example) |> Part1.simulate
    assert val == 1
  end

  test "simulation gives 4647 for puzzle input" do
    val = Part1.parse(Aoc.puzzle_input(8)) |> Part1.simulate
    assert val == 4647
  end
end

