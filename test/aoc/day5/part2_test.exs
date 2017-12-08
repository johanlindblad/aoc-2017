defmodule Aoc.Day5.Part2Test do
  use ExUnit.Case
  alias Aoc.Day5.Part2
  doctest Aoc.Day5.Part2

  # Until it is not as slow
  @tag :slow
  test "puzzle input gives 29629538" do
    assert Part2.steps_to_exit(Aoc.puzzle_input(5)) == 29629538
  end
end

