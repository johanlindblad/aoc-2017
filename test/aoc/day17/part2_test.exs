defmodule Aoc.Day17.Part2Test do
  use ExUnit.Case
  alias Aoc.Day17.Part2
  doctest Aoc.Day17.Part2

  @tag :slow
  test "puzzle input gives 27361412" do
    input = Aoc.puzzle_input(17) |> String.trim |> String.to_integer
    assert Part2.value_after(50_000_000, input) == 27361412
  end
end

