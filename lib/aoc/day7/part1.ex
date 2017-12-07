defmodule Aoc.Day7.Part1 do
  def parse_and_find(input) do
    parse_structure(input)
    |> root_of
  end

  @doc """
  Finds the root of the tree

  ## Examples

  iex> Aoc.Day7.Part1.root_of([{:a, []}, {:b, [:a]}])
  :b
  iex> Aoc.Day7.Part1.root_of([{:a, []}, {:b, [:a]}, {:c, [:b]}])
  :c

  """
  def root_of(nodes) do
    node_names = nodes |> Enum.map(&(elem(&1, 0))) |> MapSet.new
    child_lists = nodes |> Enum.map(&(elem(&1, 1))) |> List.flatten

    Enum.reduce(child_lists, node_names, fn(child, nodes) ->
      MapSet.delete(nodes, child)
    end)
    |> MapSet.to_list
    |> List.first
  end

  def parse_structure(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&(parse_line(&1)))
  end
 
  @doc """
  Parses the provided line according to the spec

  ## Examples

  iex> Part1.parse_line("pbga (66)")
  {:pbga, []}
  iex> Part1.parse_line("fwft (72) -> ktlj, cntj, xhth")
  {:fwft, [:ktlj, :cntj, :xhth]}

  """
  def parse_line(line) do
    [name | rest] = line |> String.replace("->", "") |> String.split()
    [_weight | children] = rest
    {String.to_atom(name), parse_children(children)}
  end

  defp parse_children(child_string) do
    child_string
    |> Enum.map(&(String.trim_trailing(&1, ",")))
    |> Enum.map(&String.to_atom/1)
  end
end
