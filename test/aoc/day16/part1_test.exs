defmodule Aoc.Day16.Part1Test do
  use ExUnit.Case
  alias Aoc.Day16.Part1
  doctest Aoc.Day16.Part1

  test "s3 on abcde gives eabcd" do
    assert Part1.spin([:a, :b, :c, :d, :e], 3) == [:c, :d, :e, :a, :b]
  end

  test "x3/4 on eabcd givs eabdc" do
    assert Part1.exchange([:e, :a, :b, :c, :d], 3, 4) == [:e, :a, :b, :d, :c]
  end

  test "pe/b on eabdc givs baedc" do
    assert Part1.partner([:e, :a, :b, :c, :d], :e, :b) == [:b, :a, :e, :c, :d]
  end

  test "puzzle input gives cknmidebghlajpfo" do
    answer = Aoc.puzzle_input(16) |> Part1.preprocess |> Part1.run |> Enum.join("")
    assert answer == "cknmidebghlajpfo"
  end
end

