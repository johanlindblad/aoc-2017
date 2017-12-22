defmodule Aoc.Day22.Part2 do
  @states [:clean, :weakened, :infected, :flagged, :clean]

  import Aoc.Day22.Part1, only: [parse_row: 1, starting_position: 1]

  def solve(input, steps) do
    input |> parse |> walk_stream |> Enum.at(steps) |> elem(3)
  end

  def parse(input) do
    lines = input |> String.split("\n")
    coords = lines |> Enum.with_index |> Enum.flat_map(&parse_row/1)
             |> Enum.map(fn({x,y}) -> {{x,y},:infected} end) |> Enum.into(%{})
    {coords, lines |> length}
  end

  def walk_stream({infected_nodes, width}) do
    initial = {starting_position(width), infected_nodes, {0, -1}, 0}
    Stream.iterate(initial, &iterate/1)
  end

  def iterate({{x,y}, infected_nodes, {xd, yd}, infect_bursts}) do
    state_before = Map.get(infected_nodes, {x,y}, :clean)
    state = next_state(state_before)
    infected_nodes = Map.put(infected_nodes, {x,y}, state)
   
    infect_bursts = case state do
      :infected -> infect_bursts + 1
      _ -> infect_bursts
    end

    {xd, yd} = case state_before do
      :clean -> {yd, -xd} # Turn right
      :weakened -> {xd, yd} # Keep going
      :infected -> {-yd, xd} # Turn left
      :flagged -> {-xd, -yd} # Turn around
    end

    {x, y} = {x+xd, y+yd}

    {{x,y}, infected_nodes, {xd, yd}, infect_bursts}
  end

  def next_state(current) do
    i = Enum.find_index(@states, &(&1 == current)) |> Kernel.+(1)
    Enum.at(@states, i)
  end
end
