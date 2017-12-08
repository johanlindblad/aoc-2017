defmodule Aoc.Day7.Part1Test do
  use ExUnit.Case
  alias Aoc.Day7.Part1
  doctest Aoc.Day7.Part1
  @example "pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"

  test "finds tknk as root with example case" do
    assert Part1.parse_and_find(@example) == :tknk
  end

  test "puzzle input gives veboyvy" do
    assert Part1.parse_and_find(Aoc.puzzle_input(7)) == :veboyvy
  end
end

