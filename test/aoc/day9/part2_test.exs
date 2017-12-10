defmodule Aoc.Day9.Part2Test do
  use ExUnit.Case
  alias Aoc.Day9.Part2
  doctest Aoc.Day9.Part2

  test "<> gives 0", do: assert Part2.garbage_count("<>") == 0
  test "<random characters> gives 17" do
    assert Part2.garbage_count("<random characters>") == 17
  end
  test '<{o"i!a,<{i<a> gives 10' do
    assert Part2.garbage_count("<{o\"i!a,<{i<a>") == 10
  end

  test "puzzle input gives 6671" do
    assert Part2.garbage_count(Aoc.puzzle_input(9)) == 6671
  end
end

