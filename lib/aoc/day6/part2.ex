defmodule Aoc.Day6.Part2 do
  alias Aoc.Day6.Part1

  def steps_until_repeat(banks) when is_binary(banks) do
    banks |> String.split(" ") |> Enum.map(&String.to_integer/1) |> steps_until_repeat
  end
  def steps_until_repeat(banks), do: steps_until_repeat(banks, 0, %{banks => 0})
  def steps_until_repeat(banks, steps_so_far, old_configs) do
    new_config = banks |> Part1.step(Enum.count(banks))

    if Map.has_key?(old_configs, new_config) do
      (steps_so_far + 1) - Map.get(old_configs, new_config)
    else
      steps_until_repeat(new_config, steps_so_far + 1, Map.put(old_configs, new_config, steps_so_far + 1))
    end
  end
end
