defmodule Aoc.Day23.Part1Test do
  use ExUnit.Case
  alias Aoc.Day23.Part1
  doctest Aoc.Day23.Part1

  test "puzzle input gives 8281" do
    stream = Aoc.puzzle_input(23) |> Part1.preprocess |> Part1.simulation_stream
    assert Part1.num_muls(stream) == 8281
  end
end
