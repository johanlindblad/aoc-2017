defmodule Aoc.Day2.Part2Test do
  use ExUnit.Case
  alias Aoc.Day2.Part2

  @example "5 9 2 8
9 4 7 3
3 8 6 5"

  test "example gives 9" do
    assert Part2.checksum(@example) == 9
  end

  test "puzzle input produces 303" do
    assert Part2.checksum(Aoc.puzzle_input(2)) == 303
  end
end
