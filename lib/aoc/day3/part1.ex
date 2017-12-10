defmodule Aoc.Day3.Part1 do
  require Record
  Record.defrecord :square, address: 1, layer: 1, layer_width: 1, from_start: 0, to_next_layer: 1, from_corner: 0, to_corner: 2
  
  def steps(square) do
    squares()
    |> Stream.drop(square - 1)
    |> Enum.at(0)
    |> distance
  end

  def squares do
    Stream.iterate(square(), &next_square_after/1)
  end

  def next_square_after(square(address: 1)), do: {:square, 2, 2, 2, 0, 8, 1, 1}
  def next_square_after(sq = square(to_next_layer: 1, layer: layer, layer_width: layer_width)) do
    increment(sq) |> square(
      layer: layer + 1, layer_width: layer_width + 2,
      from_start: 0, to_next_layer: (layer_width * 4) + 8,
      from_corner: 1, to_corner: layer_width + 1
    )
  end
  def next_square_after(sq = square(to_corner: 1, layer_width: layer_width)) do
    increment(sq) |> square(from_corner: 0, to_corner: layer_width)
  end
  def next_square_after(sq = square()), do: increment(sq)

  def increment({:square, address, layer, layer_width, from_start, to_next_layer, from_corner, to_corner}) do
    {:square, address + 1, layer, layer_width, from_start + 1, to_next_layer - 1, from_corner + 1, to_corner - 1}
  end

  def distance(square(address: 1)), do: 0
  def distance(square(layer: layer, from_corner: from_corner, to_corner: to_corner)) do
    abs(from_corner - to_corner)
    |> div(2)
    |> Kernel.+(layer - 1)
  end
end
