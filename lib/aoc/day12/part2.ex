defmodule Aoc.Day12.Part2 do
  alias Aoc.Day12.Part1

  def solve(input), do: input |> Part1.preprocess |> num_groups |> elem(0)

  def num_groups(graph, visited \\ MapSet.new) do
    Enum.reduce(Map.keys(graph), {0, visited}, fn(node, {count, visited}) ->
      case MapSet.member?(visited, node) do
        true -> {count, visited}
        false -> 
          {_, new_visited} = Part1.in_same_group(graph, node, visited)
          {count + 1, MapSet.union(new_visited, visited)}
      end
    end)
  end
end

