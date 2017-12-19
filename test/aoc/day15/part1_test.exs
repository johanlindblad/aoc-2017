defmodule Aoc.Day15.Part1Test do
  use ExUnit.Case
  alias Aoc.Day15.Part1
  doctest Aoc.Day15.Part1

  test "example input gives 1 pair equal in 5" do
    start = [65, 8921]
    assert Part1.solve(start, 5) == 1
  end

  @tag :slow
  @tag timeout: 120000
  test "example input gives 569 pairs equal" do
    start = Aoc.puzzle_input(15) |> Part1.parse
    assert Part1.solve(start) == 569
  end
end
