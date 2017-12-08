defmodule Aoc.Day4.Part1Test do
  use ExUnit.Case
  alias Aoc.Day4.Part1
  doctest Aoc.Day4.Part1

  test "puzzle input gives 477" do
    assert Part1.num_valid(Aoc.puzzle_input(4)) == 477
  end
end
