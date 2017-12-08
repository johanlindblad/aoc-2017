defmodule Aoc.Day5.Part1Test do
  use ExUnit.Case
  alias Aoc.Day5.Part1
  doctest Aoc.Day5.Part1

  # Until it is not as slow
  @tag :slow
  test "puzzle input gives 372139" do
    assert Part1.steps_to_exit(Aoc.puzzle_input(5)) == 372139
  end
end

