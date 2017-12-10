defmodule Aoc.Day10.Part2Test do
  use ExUnit.Case
  alias Aoc.Day10.Part2
  doctest Aoc.Day10.Part2

  test "the hash for the empty string is a2582a3a0e66e6e86e3812dcb672a272" do
    assert Aoc.Day10.Part2.run("") == "a2582a3a0e66e6e86e3812dcb672a272"
  end

  test "the hash for the 'AoC 2017' is 33efeb34ea91902bb2f59c9920caa6cd" do
    assert Aoc.Day10.Part2.run("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
  end

  test "the hash for the puzzle input is 1c46642b6f2bc21db2a2149d0aeeae5d" do
    assert Aoc.Day10.Part2.run(Aoc.puzzle_input(10) |> String.trim) == "1c46642b6f2bc21db2a2149d0aeeae5d"
  end
end
