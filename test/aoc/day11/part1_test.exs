defmodule Aoc.Day11.Part1Test do
  use ExUnit.Case
  alias Aoc.Day11.Part1
  doctest Aoc.Day11.Part1

  test "ne,ne,ne gives 3" do
    assert Part1.solve("ne,ne,ne") == 3
  end

  test "ne,ne,sw,sw gives 0" do
    assert Part1.solve("ne,ne,sw,sw") == 0
  end

  test "ne,ne,s,s gives 2" do
    assert Part1.solve("ne,ne,s,s") == 2
  end

  test "se,sw,se,sw,sw gives 3" do
    assert Part1.solve("se,sw,se,sw,sw") == 3
  end

  test "ne,se gives 2" do
    assert Part1.solve("ne,se") == 2
  end

  test "puzzle input gives 818" do
    assert Part1.solve(Aoc.puzzle_input(11)) == 818
  end
end
