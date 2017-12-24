defmodule Aoc.Day24.Part1 do
  def parse(input) do
    pairs = input |> String.trim |> String.split("\n") |> Enum.map(&parse_row/1) |> Enum.into(MapSet.new())

    map = Enum.reduce(pairs, %{}, fn({a,b}, map) ->
      Map.update(map, a, MapSet.new([b]), fn(set) -> MapSet.put(set, b) end)
      |> Map.update(b, MapSet.new([a]), fn(set) -> MapSet.put(set, a) end)
    end)

    {map, {pairs, 0, 0}}
  end

  def parse_row(row) do
    row |> String.split("/") |> Enum.map(&String.to_integer/1) |> List.to_tuple
  end

  # state = {remaining, score, port}
  def iterate(state_list, map, max \\ 0)
  def iterate([], _, max), do: max
  def iterate(state_list, map, max) do
    next_states = Enum.reduce(state_list, [], fn({remaining, score, port}, next_states) ->
      extra = Enum.filter(_options = map[port], fn(other) -> 
        MapSet.member?(remaining, {port, other}) || MapSet.member?(remaining, {other, port})
      end)
      |> Enum.map(fn(other_port) ->
        extra_score = other_port + port
        remaining = MapSet.delete(remaining, {port, other_port})
                    |> MapSet.delete({other_port, port})
        {remaining, score + extra_score, other_port}
      end)

      extra ++ next_states
    end)

    scores = Enum.map(next_states, fn({_,score,_}) -> score end)
    max = Enum.max([max | scores])

    iterate(next_states, map, max)
  end
end
