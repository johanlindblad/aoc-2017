defmodule Aoc.Day15.Part2Test do
  use ExUnit.Case
  alias Aoc.Day15.Part2
  doctest Aoc.Day15.Part2

  @tag :slow
  test "example input gives 309 pairs equal" do
    start = [65, 8921]
    assert Part2.solve(start) == 309
  end

  @tag :slow
  @tag timeout: 120000
  test "example input gives 569 pairs equal" do
    start = Aoc.puzzle_input(15) |> Aoc.Day15.Part1.parse
    assert Part2.solve(start) == 298
  end
end
