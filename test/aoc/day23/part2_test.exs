defmodule Aoc.Day23.Part2Test do
  use ExUnit.Case
  alias Aoc.Day23.Part2
  doctest Aoc.Day23.Part2

  test "puzzle input gives 911" do
    assert Part2.num_primes(Aoc.puzzle_input(23)) == 911
  end
end
