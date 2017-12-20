defmodule Aoc.Day20.Part2Test do
  use ExUnit.Case
  alias Aoc.Day20.Part2
  doctest Aoc.Day20.Part2

  @example "p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
  p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
  p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
  p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>"

  test "example gives 1 point left" do
    @example |> Aoc.Day20.Part1.parse |> Aoc.Day20.Part2.particles_left
  end

  @tag :slow
  test "puzzle input gives 1 point left" do
    Aoc.puzzle_input(20) |> Aoc.Day20.Part1.parse |> Aoc.Day20.Part2.particles_left
  end
end


