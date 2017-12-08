defmodule Aoc.Day5.Part1 do
  def steps_to_exit(input_string) do
    input_string
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> simulate()
  end

  @doc """
  Simulates the given instructions and returns the number of steps

  ## Example

  iex> Part1.simulate([0, 3, 0, 1, -3])
  5
  iex> Part1.simulate([-2, 1])
  1
    
  """
  def simulate(instructions), do: simulate([], instructions, 0)
  def simulate([], [instruction | _next], steps) when instruction < 0, do: steps + 1
  def simulate(previous, [instruction | next], steps) do
    {previous, next} = step(previous, [instruction + 1 | next], instruction)

    case next do
      [_head | _tail] -> simulate(previous, next, steps + 1)
      [] -> steps + 1
    end
  end

  @doc """
  Shuffles instructions from next to previous times times

  ## Example
  iex> Part1.step([2,1,0], [3,4,5], 2)
  {[4, 3, 2, 1, 0], [5]}
  iex> Part1.step([2,1,0], [3,4,5], -2)
  {[0], [1,2,3,4,5]}
  """
  def step(previous, next, 0), do: {previous, next}
  def step(previous, [instruction | next], times) when times > 0 do
    step([instruction | previous], next, times - 1)
  end
  def step([instruction | previous], next, times) do
    step(previous, [instruction | next], times + 1)
  end
end
