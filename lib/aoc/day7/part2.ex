defmodule Aoc.Day7.Part2 do
  alias Aoc.Day7.Part1

  def parse_and_find(input) do
    {_, tree} = Part1.parse_structure(input) |> build_tree
    weights = parse_weights(input)

    mismatch(tree, weights)
  end

  @doc """
  Calculates the new weight of the mismatch-solving node

  ## Examples

  iex> Aoc.Day7.Part2.mismatch(%{b: %{a: %{}, c: %{}}}, %{a: 5, b: 6, c: 4})
  3

  """
  def mismatch(tree, weights) do
    subweights =
      Map.keys(tree)
      |> Enum.map(fn(key) -> weight(tree, weights, key) end)

    if Enum.uniq(subweights) |> Enum.count > 1 do
      odd_weight = unique_element(subweights)
      odd_index = subweights |> Enum.find_index(&(&1 == odd_weight))
      odd_node = Map.keys(tree) |> Enum.at(odd_index)
      diff = Enum.max(subweights) - Enum.min(subweights)

      if mismatch(tree[odd_node], weights) == 0 do
        weights[odd_node] - diff
      else
        mismatch(tree[odd_node], weights)
      end
    else
      Map.values(tree)
      |> Enum.map(&(mismatch(&1, weights)))
      |> Enum.sum
    end
  end

  @doc """
  Returns the one unique element

  ## Examples

  iex> Aoc.Day7.Part2.unique_element([2,1,1])
  2
  iex> Aoc.Day7.Part2.unique_element([1,1,2])
  2

  """
  def unique_element([head | tail]), do: unique_element(tail, head)
  def unique_element([head | tail], candidate) when head == candidate, do: unique_element(tail, candidate)
  def unique_element([head], _candidate), do: head
  def unique_element([head | tail], candidate), do: unique_element(tail, candidate, head)
  def unique_element([head | _tail], candidate, other) when head == candidate, do: other
  def unique_element([head | _tail], candidate, other) when head == other, do: candidate

  @doc """
  Calculates the weight of the tree

  ## Examples

  iex> Aoc.Day7.Part2.weight(%{b: %{a: %{}, c: %{}}}, %{a: 5, b: 6, c: 4}, :b)
  15

  """
  def weight(tree, weights, key) do
    subtree_weight = 
      Map.keys(tree[key])
      |> Enum.map(fn(name) -> weight(tree[key], weights, name) end)
      |> Enum.sum

    weights[key] + subtree_weight
  end

  @doc """
  Builds the described tree

  ## Examples

  iex> Aoc.Day7.Part2.build_tree([{:a, []}, {:b, [:a]}])
  {%{}, %{b: %{a: %{}}}}

  """
  def build_tree(descriptions), do: build_tree(Enum.into(descriptions, %{}), %{})
  def build_tree(structure_map, tree) when map_size(structure_map) == 0, do: {structure_map, tree}
  def build_tree(structure_map, tree), do: build_tree(structure_map, tree, Part1.root_of(structure_map))
  def build_tree(structure_map, tree, node_name) do
    {children, structure_map} = Map.pop(structure_map, node_name)

    {structure_map, tree} = Enum.reduce(children, {structure_map, tree}, fn(child, {structure_map, tree}) ->
      build_tree(structure_map, tree, child)
    end)

    subtree = Map.take(tree, children)
    tree = Map.put(tree, node_name, subtree)
           |> Map.drop(children)

    {structure_map, tree}
  end

  @doc """
  Builds a map of node weights from the description

  ## Examples

  iex> Aoc.Day7.Part2.parse_weights("pbga (66)
  iex> xhth (57)")
  %{pbga: 66, xhth: 57}

  """
  def parse_weights(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&(parse_line(&1)))
    |> Enum.into(%{})
  end

  defp parse_line(line) do
    [name | rest] = line |> String.replace(~r/\(|\)|->/, "") |> String.split()
    [weight | _children] = rest
    {String.to_atom(name), String.to_integer(weight)}
  end
end
