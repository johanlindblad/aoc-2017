defmodule Aoc.Day17.Part2 do
  def value_after(num_insertions, steps) do
    {last, _} = Enum.reduce(0..num_insertions, {0, 0}, fn(current, {last, index}) ->
      next_index = (1 + index + steps) |> rem(current + 1)

      case index do
        0 -> {current, next_index}
        _ -> {last, next_index}
      end
    end)

    last
  end
end
