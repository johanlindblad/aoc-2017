defmodule Aoc.Day24.Part1Test do
  use ExUnit.Case
  alias Aoc.Day24.Part1
  doctest Aoc.Day24.Part1
  @example "0/2\n2/2\n2/3\n3/4\n3/5\n0/1\n10/1\n9/10\n"

  test "example input gives 31" do
    score = @example |> Part1.parse |> Part1.solve
    assert score == 31
  end

  @tag :slow
  test "puzzle input gives 1940" do
    score = Aoc.puzzle_input(24) |> Part1.parse |> Part1.solve
    assert score == 1940
  end
end
