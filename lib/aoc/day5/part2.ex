defmodule Aoc.Day5.Part2 do
  alias Aoc.Day5.Part1

  def steps_to_exit(input_string) do
    input_string
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> simulate()
  end

  @doc """
  Simulates the given instructions and returns the number of steps

  ## Example

  iex> Part2.simulate([0, 3, 0, 1, -3])
  10
    
  """
  def simulate(instructions), do: simulate([], instructions, 0)
  def simulate([], [instruction | _next], steps) when instruction < 0, do: steps + 1
  def simulate(previous, [instruction | next], steps) do
    {previous, next} = step(previous, [new_offset(instruction) | next], instruction)

    case next do
      [_head | _tail] -> simulate(previous, next, steps + 1)
      [] -> steps + 1
    end
  end

  defdelegate step(previous, next, times), to: Part1

  defp new_offset(old_offset) when old_offset >= 3, do: old_offset - 1
  defp new_offset(old_offset), do: old_offset + 1
end

