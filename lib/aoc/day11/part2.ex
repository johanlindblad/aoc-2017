defmodule Aoc.Day11.Part2 do
  alias Aoc.Day11.Part1

  def solve(input), do: input |> Part1.preprocess |> max_distance

  def max_distance(steps) do
    steps
    |> Enum.map(&Part1.effect/1)
    |> Enum.reduce({0, {0, 0}}, fn(step, {max_d, coord}) ->
      coord = Part1.sum(coord, step)
      {max(max_d, Part1.distance(coord)), coord}
    end)
    |> elem(0)
  end
end
