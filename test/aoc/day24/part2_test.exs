defmodule Aoc.Day24.Part2Test do
  use ExUnit.Case
  alias Aoc.Day24.Part1
  alias Aoc.Day24.Part2
  doctest Aoc.Day24.Part2
  @example "0/2\n2/2\n2/3\n3/4\n3/5\n0/1\n10/1\n9/10\n"

  test "example input gives 19" do
    score = @example |> Part1.parse |> Part2.solve
    assert score == 19
  end

  @tag :slow
  test "puzzle input gives 1928" do
    score = Aoc.puzzle_input(24) |> Part1.parse |> Part2.solve
    assert score == 1928
  end
end
