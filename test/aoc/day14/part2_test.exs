defmodule Aoc.Day14.Part2Test do
  use ExUnit.Case
  alias Aoc.Day14.Part2
  doctest Aoc.Day14.Part2

  @tag :slow
  test "example input gives 1242" do
    assert Part2.solve("flqrgnkx") == 1242
  end

  @tag :slow
  test "example input gives 1113" do
    input = Aoc.puzzle_input(14) |> String.trim
    assert Part2.solve(input) == 1113
  end
end



