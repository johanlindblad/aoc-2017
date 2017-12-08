defmodule Aoc.Day8.Part2Test do
  use ExUnit.Case
  alias Aoc.Day8.Part2
  doctest Aoc.Day8.Part2
  @example "b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"

  test "simulation gives 10 for example input" do
    val = Part2.parse(@example) |> Part2.simulate
    assert val == 10
  end
end

