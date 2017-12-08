defmodule Aoc.Day7.Part2Test do
  use ExUnit.Case
  alias Aoc.Day7.Part2
  alias Aoc.Day7.Part1
  doctest Aoc.Day7.Part2
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

  test "build_tree for example gives expected tree" do
    {_, tree} = Part2.build_tree(Part1.parse_structure(@example)) 
    assert tree == %{tknk: %{
      ugml: %{gyxo: %{}, ebii: %{}, jptl: %{}},
      padx: %{pbga: %{}, havc: %{}, qoyq: %{}},
      fwft: %{ktlj: %{}, cntj: %{}, xhth: %{}}
    }}
  end

  test "mismatch for example input gives 60" do
    assert Part2.parse_and_find(@example) == 60
  end

  test "mismatch for puzzle input gives 749" do
    assert Part2.parse_and_find(Aoc.puzzle_input(7)) == 749
  end
end

