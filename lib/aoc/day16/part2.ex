defmodule Aoc.Day16.Part2 do
  import Aoc.Day16.Part1, only: [start: 0]
  alias Aoc.Day16.Part1

  def solve(instructions) do
    {repeat_start, cycle_length} = repeats_after(instructions)
    reduced = rem(1_000_000_000 - repeat_start, cycle_length)

    run(instructions, reduced) |> Enum.join("")
  end

  def repeats_after(instructions) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({start(), %{}}, fn(index, {programs, previous}) ->
      case Map.get(previous, programs) do
        nil -> {:cont, {Part1.run(instructions, programs), Map.put(previous, programs, index)}}
        prev_index -> {:halt, {prev_index, index - prev_index}}
      end
    end)
  end

  def run(instructions, times) do
    Stream.iterate(start(), &(Part1.run(instructions, &1)))
    |> Enum.at(times) 
  end
end
