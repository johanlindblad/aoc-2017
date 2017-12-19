defmodule Aoc.Day18.Part2Test do
  use ExUnit.Case
  alias Aoc.Day18.{Part1,Part2}
  doctest Aoc.Day18.Part2

  @example "snd 1\nsnd 2\nsnd p\nrcv a\nrcv b\nrcv c\nrcv d"

  test "example gives 3" do
    assert Part1.preprocess(@example) |> Part2.simulation_stream |> Part2.one_sends == 3
  end

  test "puzzle input gives 7366" do
    assert Part1.preprocess(Aoc.puzzle_input(18)) |> Part2.simulation_stream |> Part2.one_sends == 7366
  end
end

