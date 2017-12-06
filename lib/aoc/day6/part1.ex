defmodule Aoc.Day6.Part1 do
  def steps_until_repeat(banks) when is_binary(banks) do
    banks |> String.split(" ") |> Enum.map(&String.to_integer/1) |> steps_until_repeat
  end
  def steps_until_repeat(banks), do: steps_until_repeat(banks, 0, MapSet.new |> MapSet.put(banks))
  def steps_until_repeat(banks, steps_so_far, old_configs) do
    new_config = banks |> step(Enum.count(banks))

    if MapSet.member?(old_configs, new_config) do
      steps_so_far + 1
    else
      steps_until_repeat(new_config, steps_so_far + 1, MapSet.put(old_configs, new_config))
    end
  end

  def step(banks), do: step(banks, Enum.count(banks))
  def step(banks, num_banks) do
    {max, max_bank} = banks |> Enum.with_index |> Enum.max_by(&(elem(&1, 0)))
    next_bank = rem(max_bank + 1, num_banks)
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

  def add_ones(banks, from, num), do: add_ones(banks, from, num, Enum.count(banks))
  def add_ones(banks, from, num, list_size) do
    Stream.cycle(0..(list_size - 1))
    |> Stream.drop(from)
    |> Enum.take(num)
    |> Enum.reduce(banks, fn(index, banks) ->
      List.update_at(banks, index, &(&1 + 1))
    end)
    |> Enum.to_list
  end
end
