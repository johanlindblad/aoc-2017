defmodule Aoc.Day3.Part2Test do
  use ExUnit.Case
  alias Aoc.Day3.Part2
  doctest Aoc.Day3.Part2

  test "first 10 values" do
    assert Part2.values |> Enum.take(10) == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26]
  end
  
  test "rest of shown" do
    assert Part2.values |> Stream.drop(10) |> Enum.take(13) == [54, 57, 59, 122, 133, 142, 147, 304, 330, 351, 362, 747, 806]
  end

  test "puzzle input gives 279138" do
    n = Aoc.puzzle_input(3) |> String.trim |> String.to_integer
    assert Part2.first_greater_than(n) == 279138
  end
end
