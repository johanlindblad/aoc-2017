defmodule Aoc.Day23.Part2 do
  alias Aoc.Day23.Part1
  require Aoc.Day23.Part1

  def num_primes(instructions) do
    s = "set a 1\n" <> instructions |> Part1.preprocess |> Part1.simulation_stream
    machine = s |> Enum.at(8)
    [_, b, c | _] = Part1.machine(machine, :registers)

    Stream.iterate(b, &(&1 + 17))
    |> Stream.take_while(&(&1 <= c))
    |> Stream.filter(fn(b) ->
      up_to = :math.sqrt(b) |> Float.ceil |> round
      Enum.any?(2..(up_to), &(rem(b, &1) == 0))
    end)
    |> Enum.count
  end
end
