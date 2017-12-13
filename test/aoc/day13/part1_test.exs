defmodule Aoc.Day13.Part1Test do
  use ExUnit.Case
  alias Aoc.Day13.Part1
  doctest Aoc.Day13.Part1

  @example "0: 3
1: 2
4: 4
6: 4"

  test "example input gives 24" do
    assert Part1.solve(@example) == 24
  end
end


