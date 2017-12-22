defmodule Aoc.Day22.Part1Test do
  use ExUnit.Case
  alias Aoc.Day22.Part1
  doctest Aoc.Day22.Part1

  @example "..#\n#..\n..."

  test "example input gives 5587" do
    assert Part1.solve(@example, 10000) == 5587
  end
end
