defmodule Aoc.Day3.Part2Test do
  use ExUnit.Case
  alias Aoc.Day3.Part2
  doctest Aoc.Day3.Part2

  test "first 10 values" do
    assert Enum.map(1..10, &Part2.value/1) == [1, 1, 2, 4, 5, 10, 11, 23, 25, 26]
  end
  
  test "rest of shown" do
    assert Enum.map(11..23, &Part2.value/1) == [54, 57, 59, 122, 133, 142, 147, 304, 330, 351, 362, 747, 806]
  end

  # Until it is no longer slow
  @tag :slow
  test "puzzle input gives 279138" do
    n = Aoc.puzzle_input(3) |> String.trim |> String.to_integer
    assert Part2.first_greater_than(n) == 279138
  end
end
