defmodule Aoc.Day22.Part1 do
  def solve(input, steps) do
    input |> parse |> walk_stream |> Enum.at(steps) |> elem(3)
  end

  def parse(input) do
    lines = input |> String.split("\n")
    coords = lines |> Enum.with_index |> Enum.flat_map(&parse_row/1)
             |> Enum.into(MapSet.new())
    {coords, lines |> length}
  end

  def parse_row(row_and_y, x \\ 0, acc \\ [])
  def parse_row({"", _}, _, acc), do: acc
  def parse_row({"#" <> rest, y}, x, acc), do: parse_row({rest,y}, x+1, [{x,y} | acc])
  def parse_row({"." <> rest, y}, x, acc), do: parse_row({rest,y}, x+1, acc)

  def walk_stream({infected_nodes, width}) do
    initial = {starting_position(width), infected_nodes, {0, -1}, 0}
    Stream.iterate(initial, &iterate/1)
  end

  def iterate({{x,y}, infected_nodes, {xd, yd}, infect_bursts}) do
    infected = MapSet.member?(infected_nodes, {x,y})
   
    {infected_nodes, infect_bursts} = case infected do
      true -> {MapSet.delete(infected_nodes, {x,y}), infect_bursts}
      false -> {MapSet.put(infected_nodes, {x,y}), infect_bursts + 1}
    end

    {xd, yd} = case infected do
      true -> {-yd, xd} # Turn left
      false -> {yd, -xd} # Turn right
    end

    {x, y} = {x+xd, y+yd}

    {{x,y}, infected_nodes, {xd, yd}, infect_bursts}
  end

  def starting_position(width), do: {div(width-1, 2), div(width-1, 2)}
end
