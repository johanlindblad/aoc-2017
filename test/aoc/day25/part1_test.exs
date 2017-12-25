defmodule Aoc.Day25.Part1Test do
  use ExUnit.Case
  alias Aoc.Day25.Part1
  doctest Aoc.Day25.Part1

    @example "Begin in state A.
Perform a diagnostic checksum after 6 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A."

  test "example input gives 3" do
    sum = @example |> Part1.parse |> Part1.diagnostic_checksum
    assert sum == 3
  end

  @tag :slow
  test "puzzle input gives 4387" do
    sum = Aoc.puzzle_input(25) |> Part1.parse |> Part1.diagnostic_checksum
    assert sum == 4387
  end
end
