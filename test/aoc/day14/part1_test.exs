defmodule Aoc.Day14.Part1Test do
  use ExUnit.Case
  alias Aoc.Day14.Part1
  doctest Aoc.Day14.Part1

  @tag :slow
  test "example input gives 8108" do
    assert Part1.num_ones("flqrgnkx") == 8108
  end

  @tag :slow
  test "puzzle input gives 8250" do
    result = Aoc.puzzle_input(14) |> String.trim |> Part1.num_ones
    assert result == 8250
  end
end



