defmodule Aoc.Day12.Part1 do
  def solve(input), do: input |> preprocess |> in_same_group |> elem(0)

  def preprocess(input) do
    String.trim(input) |> String.split("\n") |> Enum.map(&preprocess_row/1)
    |> Enum.into(%{})
  end
  def preprocess_row(row) do
    [program, "<->" | rest] = String.split(row)
    linked = rest |> Enum.map(&String.replace_trailing(&1, ",", "")) |> Enum.map(&String.to_integer/1)
    {String.to_integer(program), linked}
  end

  def in_same_group(graph, node \\ 0, visited \\ MapSet.new()) do
    unvisited = Enum.reject(graph[node], &(MapSet.member?(visited, &1)))
    visited = [node | unvisited] |> MapSet.new() |> MapSet.union(visited)

    {count, new_visited} = 
      unvisited 
      |> Enum.map(&(in_same_group(graph, &1, visited))) 
      |> Enum.reduce({0, MapSet.new()}, fn({count, visited}, {total, acc_visited}) ->
        {count + total, MapSet.union(visited, acc_visited)}
      end)

    {count + 1, MapSet.union(visited, new_visited)}
  end
end
