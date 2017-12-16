defmodule Aoc.Day16.Part2Test do
  use ExUnit.Case
  alias Aoc.Day16.Part1
  alias Aoc.Day16.Part2
  doctest Aoc.Day16.Part2

  @tag :slow
  test "puzzle input has a cycle length of 60" do
    {0, cycle_length} = Aoc.puzzle_input(16) |> Part1.preprocess |> Part2.repeats_after
    assert cycle_length == 60
  end

  @tag :slow
  test "puzzle input gives cbolhmkgfpenidaj" do
    answer = Aoc.puzzle_input(16) |> Part1.preprocess |> Part2.solve
    assert answer == "cbolhmkgfpenidaj"
  end
end

