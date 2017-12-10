defmodule Aoc.Day9.Part1Test do
  use ExUnit.Case
  alias Aoc.Day9.Part1
  doctest Aoc.Day9.Part1

  test "{} gives 1", do: assert Part1.score("{}") == 1
  test "{{{}}} gives 6", do: assert Part1.score("{{{}}}") == 6
  test "{{},{}} gives 5", do: assert Part1.score("{{},{}}") == 5
  test "{{<a!>},{<a!>},{<a!>},{<ab>}} gives 3" do
    assert Part1.score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end

  test "puzzle input gives 12505" do
    assert Part1.score(Aoc.puzzle_input(9)) == 12505
  end
end

