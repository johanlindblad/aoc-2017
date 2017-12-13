defmodule Aoc.Day13.Part2 do
  alias Aoc.Day13.Part1

  def solve(input), do: input |> Part1.preprocess |> required_delay

  def required_delay(layers, delay \\ 0) do
    case Enum.any?(layers, &(Part1.caught_at(&1, delay))) do
      true -> required_delay(layers, delay + 1)
      false -> delay
    end
  end
end
