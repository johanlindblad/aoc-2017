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
  def mismatch(tree, _) when map_size(tree) == 0, do: 0
  def mismatch(tree, weights) do
    subweights = Map.keys(tree)
                 |> Enum.map(&(weight(tree, weights, &1)))

    if Enum.uniq(subweights) |> Enum.count > 1 do
      {_odd_weight, odd_index} = unique_element(subweights)
      odd_node = Map.keys(tree) |> Enum.at(odd_index)
      diff = Enum.max(subweights) - Enum.min(subweights)

      case mismatch(tree[odd_node], weights) do
        0 -> weights[odd_node] - diff
        mismatch -> mismatch
      end
    else
      Map.values(tree)
      |> Enum.map(&(mismatch(&1, weights)))
      |> Enum.sum
    end
  end

  @doc """
  Returns the one unique element and its index

  ## Examples

  iex> Aoc.Day7.Part2.unique_element([2,1,1])
  {2,0}
  iex> Aoc.Day7.Part2.unique_element([1,2,1])
  {2,1}
  iex> Aoc.Day7.Part2.unique_element([1,1,2])
  {2,2}

  """
  def unique_element([head | tail]), do: unique_element(tail, {head, 0}, 0)
  def unique_element([candidate | tail], {candidate, index}, at), do: unique_element(tail, {candidate, index}, at + 1)
  def unique_element([head], _candidate, at), do: {head, at + 1}
  def unique_element([head | tail], {candidate, index}, at), do: unique_element(tail, {candidate, index}, {head, at + 1}, at + 1)
  def unique_element([candidate | _tail], {candidate, _}, {other, index}, _at), do: {other, index}
  def unique_element([other | _tail], {candidate, index}, {other, _}, _at), do: {candidate, index}

  @doc """
  Calculates the weight of the tree

  ## Examples

  iex> Aoc.Day7.Part2.weight(%{b: %{a: %{}, c: %{}}}, %{a: 5, b: 6, c: 4}, :b)
  15

  """
  def weight(tree, weights, key) do
    subtree_weight = 
      Map.keys(tree[key])
      |> Enum.map(&(weight(tree[key], weights, &1)))
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
  iex>xhth (57)")
  %{pbga: 66, xhth: 57}

  """
  def parse_weights(lines) do
    lines
    |> String.trim
    |> String.replace(~r/\(|\)|->/, "")
    |> String.split("\n")
    |> Enum.map(&(parse_line(&1)))
    |> Enum.into(%{})
  end

  defp parse_line([name, weight | _]), do: {String.to_atom(name), String.to_integer(weight)}
  defp parse_line(line), do: parse_line(String.split(line, " "))
end
