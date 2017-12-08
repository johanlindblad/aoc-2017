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
  def parse_line([name, _weight]), do: {String.to_atom(name), []}
  def parse_line([name, _weight, "->" | children]), do: {String.to_atom(name), Enum.map(children, &clean/1)}
  def parse_line(line), do: parse_line(String.split(line, " "))
  defp clean(child_string), do: child_string |> String.trim_trailing(",") |> String.to_atom
end
