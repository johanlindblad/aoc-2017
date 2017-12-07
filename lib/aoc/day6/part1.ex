defmodule Aoc.Day6.Part1 do
  def steps_until_repeat(banks_string) when is_binary(banks_string) do
    banks_string |> String.split(" ") |> Enum.map(&String.to_integer/1) |> steps_until_repeat
  end
  def steps_until_repeat(banks), do: steps_until_repeat(banks, 0, MapSet.new |> MapSet.put(banks))
  def steps_until_repeat(banks, steps_so_far, old_configs) do
    new_config = banks |> step()

    if MapSet.member?(old_configs, new_config) do
      steps_so_far + 1
    else
      steps_until_repeat(new_config, steps_so_far + 1, MapSet.put(old_configs, new_config))
    end
  end

  def step(banks) do
    {max, max_bank} = banks |> Enum.with_index |> Enum.max_by(&(elem(&1, 0)))
    next_bank = rem(max_bank + 1, length(banks))
    cleared = List.replace_at(banks, max_bank, 0)
    add_ones(cleared, next_bank, max)
  end

  @doc """
  Adds 1 to each element from index `from` and num times

  ## Example

  iex> Part1.add_ones([0, 1, 2, 3, 4, 5], 4, 3)
  [1, 1, 2, 3, 5, 6]
  iex> Part1.add_ones([0, 1, 2, 4], 0, 14)
  [4, 5, 5, 7]
  iex> Part1.add_ones([1, 2, 3, 1], 0, 1)
  [2, 2, 3, 1]
  iex> Part1.add_ones([0, 1, 2, 0], 0, 5)
  [2, 2, 3, 1]

  """
  def add_ones(banks, from, num) do
    left = length(banks) - rem(from + num, length(banks))
    {rest, banks} = Enum.split(banks, from)
    {tail, neck} = inner_add_ones(banks, rest, num) |> Enum.split(left)
    neck ++ tail
  end
  def inner_add_ones(neck, tail, 0), do: neck ++ tail
  def inner_add_ones([], rest, num), do: inner_add_ones(rest, [], num)
  def inner_add_ones([head | tail], rest, num), do: inner_add_ones(tail, rest ++ [head + 1], num - 1)
end
