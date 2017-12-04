defmodule Aoc.Day3.Part1 do
  use Bitwise
  # Can be decomposed into one vector inwards and one vector
  # pointing to the center of the current row
  def steps(1), do: 0
  def steps(square) do
    # The first vector is simply the layer number
    inward = layer_number(square)

    layer_number = layer_number(square)
    # widest point
    layer_width = (2 * layer_number) + 1

    distance_from_start = square - first_in_layer(layer_number)
    from_last_corner = 1 + rem(distance_from_start, layer_width - 1)
    to_next_corner = (layer_width - 1) - from_last_corner
    distance_to_center = abs(div(from_last_corner - to_next_corner, 2))

    inward + distance_to_center
  end

  @doc """
  Returns the layer in which the given square resides

  ## Examples

  iex> Part1.layer_number(25)
  2
  iex> Part1.layer_number(26)
  3
    
  """
  def layer_number(square) do
    layer_sizes()
    |> Stream.take_while(fn(n) -> n < (square - 1) end)
    |> Enum.to_list
    |> Kernel.length
    |> Kernel.+(1)
  end

  @doc """
  Returns the first number of the given layer

  ## Examples

  iex> Part1.first_in_layer(1)
  2
  iex> Part1.first_in_layer(2)
  10
  iex> Part1.first_in_layer(3)
  26
    
"""
  def first_in_layer(1), do: 2
  def first_in_layer(layer) do
    layer_sizes()
    |> Enum.take(layer - 1)
    |> Enum.at(-1)
    |> Kernel.+(2)
  end

  defp layer_sizes do
    triangle_numbers()
    |> Stream.map(fn(t_num) -> 8 * t_num end)
  end

  defp triangle_numbers do
    natural_numbers()
    |> Stream.scan(fn(num, acc) -> acc + num end)
  end

  defp natural_numbers do
    Stream.iterate(1, &(&1 + 1))
  end
end
