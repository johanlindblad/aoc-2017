defmodule Aoc.Day19.Part2 do
  def num_steps(simulation_stream) do
    simulation_stream |> Enum.count
  end
end
