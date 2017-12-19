defmodule Aoc.Day18.Part1Test do
  use ExUnit.Case
  alias Aoc.Day18.Part1
  doctest Aoc.Day18.Part1

  @example "set a 1\nadd a 2\nmul a a\nmod a 5\nsnd a\nset a 0\nrcv a\njgz a -1\nset a 1\njgz a -2"

  test "example gives 4" do
    received_values = Part1.preprocess(@example) |> Part1.loopback_stream |> Part1.received_values
    assert received_values |> Enum.at(0) == 4
  end

  test "puzzle input gives 2951" do
    received_values = Part1.preprocess(Aoc.puzzle_input(18)) |> Part1.loopback_stream |> Part1.received_values
    assert received_values |> Enum.at(0) == 2951
  end
end

