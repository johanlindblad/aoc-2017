defmodule Aoc.Day24.Part1 do
  def parse(input) do
    pairs = input |> String.trim |> String.split("\n") |> Enum.map(&parse_row/1) |> Enum.into(MapSet.new())

    map = Enum.reduce(pairs, %{}, fn({a,b}, map) ->
      Map.update(map, a, MapSet.new([{a,b}]), fn(set) -> MapSet.put(set, {a,b}) end)
      |> Map.update(b, MapSet.new([{a,b}]), fn(set) -> MapSet.put(set, {a,b}) end)
    end)

    {map, {pairs, 0, 0}}
  end

  def parse_row(row) do
    row |> String.split("/") |> Enum.map(&String.to_integer/1) |> List.to_tuple
  end

  def solve({map, initial_state}), do: max_score([initial_state], map)

  # state = {remaining, score, port}
  def max_score(state_list, map, max \\ 0)
  def max_score([], _, max), do: max
  def max_score(state_list, map, max) do
    {next_states, max} = Enum.reduce(state_list, {[], max}, fn({remaining, score, port}, {next_states, max}) ->
      Enum.filter(_options = map[port], fn(other) -> 
        MapSet.member?(remaining, other)
      end)
      |> Enum.reduce({next_states, max}, fn({a,b}, {next_states, max}) ->
        contact_score = a + b
        remaining = MapSet.delete(remaining, {a,b})
        new_state = {remaining, score + contact_score, contact_score - port}
        max = max(max, score + contact_score)
        {[new_state | next_states], max}
      end)
    end)

    max_score(next_states, map, max)
  end
end
