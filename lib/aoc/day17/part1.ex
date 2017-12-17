defmodule Aoc.Day17.Part1 do
  def value_after(num_insertions, steps) do
    {index, list} = Enum.reduce(0..num_insertions, {0, []}, fn(_i, {index, list}) ->
      step(list, index, steps)
    end)

    Enum.at(list, index + 1)
  end

  def step([], _, _), do: {1, [0]}
  def step(list, current_index, steps) do
    value = length(list)
    index = (1 + current_index + steps) |> rem(length(list))
    {index, List.insert_at(list, index, value)}
  end
end
