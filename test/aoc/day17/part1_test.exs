defmodule Aoc.Day17.Part1Test do
  use ExUnit.Case
  alias Aoc.Day17.Part1
  doctest Aoc.Day17.Part1

  test "example gives 638" do
    assert Part1.value_after(2017, 3) == 638
  end

  test "puzzle input gives 725" do
    input = Aoc.puzzle_input(17) |> String.trim |> String.to_integer
    assert Part1.value_after(2017, input) == 725
  end
end

