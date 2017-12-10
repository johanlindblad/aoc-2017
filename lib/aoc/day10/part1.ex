defmodule Aoc.Day10.Part1 do
  def run(input_string, size \\ 256)
  def run(input_string, size) when is_binary(input_string) do
    input_string |> String.trim |> String.split(",") |> Enum.map(&String.to_integer/1)
    |> hash(size)
    |> elem(3)
  end

  def hash(instructions, size), do: hash(Enum.to_list(0..size-1), size, instructions)
  def hash(list, size, instructions, position \\ 0, skip_size \\ 0)
  def hash(list, _size, [], position, skip_size) do
    product = rotate(list, -position) |> Enum.take(2) |> Enum.reduce(&Kernel.*/2)
    {list, position, skip_size, product}
  end
  def hash(list, size, [instruction | rest], position, skip_size) do
    rotate_n = instruction + skip_size
    list = list
           |> Enum.reverse_slice(0, instruction)
           |> rotate(rotate_n)

    position = position + rotate_n
    hash(list, size, rest, position, skip_size + 1)
  end

  @doc """
  Rotates a list a given amount of steps

  ## Example

  iex> Part1.rotate([1,2,3], 1)
  [2,3,1]
  iex> Part1.rotate([1,2,3], 3)
  [1,2,3]
  iex> Part1.rotate([1,2,3], -1)
  [3,1,2]
    
  """
  def rotate(list, steps)
  def rotate(list, 0), do: list
  def rotate(list, steps) when steps >= length(list), do: rotate(list, rem(steps, length(list)))
  def rotate(list, steps) when steps < 0, do: rotate(list, length(list) + rem(steps, length(list)))
  def rotate([head | tail], steps), do: rotate(tail ++ [head], steps - 1)
end
