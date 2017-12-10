defmodule Aoc.Day10.Part1Test do
  use ExUnit.Case
  alias Aoc.Day10.Part1
  doctest Aoc.Day10.Part1

  @example {5, [3, 4, 1, 5]}

  test "example input gives 12" do
    {size, instructions} = @example
    {_, _, _, product} = Part1.hash(instructions, size)
    assert product == 12
  end

  test "puzzle input gives 48705" do
    assert Part1.run(Aoc.puzzle_input(10)) == 48705
  end
end
