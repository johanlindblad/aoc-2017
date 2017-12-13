defmodule Aoc.Day13.Part2Test do
  use ExUnit.Case
  alias Aoc.Day13.Part2
  doctest Aoc.Day13.Part2

  @example "0: 3
1: 2
4: 4
6: 4"

  test "example input gives 10" do
    assert Part2.solve(@example) == 10
  end

  test "puzzle input gives 3833504" do
    assert Aoc.puzzle_input(13) |> Part2.solve == 3833504
  end
end


