defmodule Aoc.Day6.Part2 do
  alias Aoc.Day6.Part1

  def cycle_length(banks_string) when is_binary(banks_string) do
    banks_string |> String.trim |> String.split |> Enum.map(&String.to_integer/1) |> cycle_length
  end
  def cycle_length(banks), do: cycle_length(banks, 1, %{banks => 0})
  def cycle_length(banks, step, old_configs) do
    new_config = banks |> Part1.step()

    if Map.has_key?(old_configs, new_config) do
      step - Map.get(old_configs, new_config)
    else
      cycle_length(new_config, step + 1, Map.put(old_configs, new_config, step))
    end
  end
end
