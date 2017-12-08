defmodule Aoc.Day3.Part1Test do
  use ExUnit.Case
  alias Aoc.Day3.Part1
  doctest Aoc.Day3.Part1

  test "1 gives 0 steps" do
    assert Part1.steps(1) == 0
  end

  test "12 gives 3 steps" do
    assert Part1.steps(12) == 3
  end

  test "23 gives 2 steps" do
    assert Part1.steps(23) == 2
  end

  test "1024 gives 31 steps" do
    assert Part1.steps(1024) == 31
  end

  test "puzzle input gives 475" do
    assert Part1.steps(Aoc.puzzle_input(3) |> String.trim |> String.to_integer) == 475
  end
end
