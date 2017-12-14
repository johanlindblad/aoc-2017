defmodule Aoc.Day14.Part2 do
  alias Aoc.Day14.Part1

  def solve(input) do
    Part1.grid(input)
    |> fill_spots
    |> join_spots
    |> disjoint_set_num_sets
  end

  def fill_spots(grid) do
    {rows, _start_from} = 
      Enum.reduce(grid, {[], 1}, fn (row, {rows, start_from}) -> 
        {row, start_from} = fill_row_spots(row, start_from)
        {rows ++ [row], start_from}
      end)

    rows
  end

  def fill_row_spots(row, start_from) do
    Enum.reduce(row, {[], start_from}, fn
      (0, {spots, start_from}) -> {spots ++ [0], start_from}
      (1,{spots, start_from}) -> {spots ++ [start_from], start_from + 1}
    end)
  end

  def join_spots(filled_spots) do
    sets = to_disjoint_set(filled_spots)
    sets = join_adjacent(filled_spots, sets)
    sets = join_upper(filled_spots, sets)
    sets
  end

  def to_disjoint_set(filled_spots) do
    List.flatten(filled_spots)
    |> Enum.filter(&(&1 > 0))
    |> Enum.reduce(%{}, &(disjoint_set_insert(&2, &1)))
  end

  def join_adjacent(filled_spots, sets) do
    Enum.reduce(filled_spots, sets, fn(row, sets) ->
      Enum.chunk_by(row, &(&1 > 0))
      |> Enum.reduce(sets, fn
        ([0 | _zeros], sets) -> sets
        (indices, sets) -> disjoint_set_join(sets, indices)
      end)
    end)
  end

  def join_upper(filled_spots, sets) do
    {_, sets} = Enum.reduce(filled_spots, {[], sets}, fn
      (row, {[], sets}) -> {row, sets}
      (row, {last_row, sets}) ->
        sets = Enum.zip(row, last_row)
        |> Enum.reduce(sets, fn
          ({i,j}, sets) when i > 0 and j > 0 -> disjoint_set_join(sets, i, j)
          (_, sets) -> sets
        end)
        {row, sets}
    end)

    sets
  end

  def disjoint_set_insert(sets = %{}, number) do
    Map.put(sets, number, MapSet.new([number]))
  end
  def disjoint_set_join(sets = %{}, first, first), do: sets
  def disjoint_set_join(sets = %{}, first, second) do
    case {sets[first], sets[second]} do
      {set1 = %MapSet{}, set2 = %MapSet{}} ->
        sets |> Map.replace(first, MapSet.union(set1, set2)) |> Map.replace(second, first)
      {%MapSet{}, _root} ->
        disjoint_set_join(sets, second, first)
      {root, set = %MapSet{}} ->
        sets |> Map.replace(second, MapSet.put(set, first)) |> disjoint_set_join(root, second)
      {root1, root1} -> sets
      {root1, root2} ->
        sets |> disjoint_set_join(root1, root2)
    end
  end
  def disjoint_set_join(sets = %{}, [key | keys]) do
    Enum.reduce(keys, sets, &(disjoint_set_join(&2, key, &1)))
  end

  def disjoint_set_num_sets(sets = %{}) do
    Map.values(sets) |> Enum.reject(&is_integer/1) |> Enum.count
  end
end
