defmodule Aoc.Day15.Part2 do
  use Bitwise
  alias Aoc.Day15.Part1

  def even_division(stream, modulo) do
    stream |> Stream.filter(&(rem(&1, modulo) == 0))
  end

  def solve(input = [_a, _b]) do
    {a, b} = Part1.number_streams(input)
    Part1.num_equal({a |> even_division(4), b |> even_division(8)}, 5_000_000)
  end
end
