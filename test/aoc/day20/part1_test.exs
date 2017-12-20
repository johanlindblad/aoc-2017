defmodule Aoc.Day20.Part1Test do
  use ExUnit.Case
  alias Aoc.Day20.Part1
  doctest Aoc.Day20.Part1

  @example "p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>"

  test "example gives 0" do
    assert Part1.parse(@example) |> Part1.closest_long_term == 0
  end

  test "puzzle input gives 457" do
    assert Part1.parse(Aoc.puzzle_input(20)) |> Part1.closest_long_term == 457
  end
end
