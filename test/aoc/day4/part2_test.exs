defmodule Aoc.Day4.Part2Test do
  use ExUnit.Case
  alias Aoc.Day4.Part2
  doctest Aoc.Day4.Part2

  test "puzzle input gives 167" do
    assert Part2.num_valid(Aoc.puzzle_input(4)) == 167
  end
end
