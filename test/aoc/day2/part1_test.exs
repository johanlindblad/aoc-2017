defmodule Aoc.Day2.Part1Test do
  use ExUnit.Case
  alias Aoc.Day2.Part1

  @example "5 1 9 5
7 5 3
2 4 6 8"

  test "example gives 18" do
    assert Part1.checksum(@example) == 18
  end

  test "puzzle input produces 41919" do
    assert Part1.checksum(Aoc.puzzle_input(2)) == 41919
  end
end
