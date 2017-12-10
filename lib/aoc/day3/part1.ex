defmodule Aoc.Day3.Part1 do
  require Record
  Record.defrecord :square, address: 1, layer: 1, index_in_layer: 0, layer_width: 1, next_layer_after: 1, from_last_corner: 0, to_next_corner: 2
  
  def steps(square) do
    squares()
    |> Stream.drop(square - 1)
    |> Enum.at(0)
    |> distance
  end

  def squares do
    Stream.iterate({:square, 1, 1, 0, 1, 1, 0, 0}, &next_square_after/1)
  end

  def next_square_after({:square, 1, _, _, _, _, _, _}), do: {:square, 2, 2, 0, 2, 9, 1, 1}
  def next_square_after(
    {:square, address, layer, _index_in_layer, layer_width, next_layer_after, _from_last_corner, _to_next_corner,}
  ) when address == next_layer_after do
    next_layer_after = next_layer_after + (layer_width * 4) + 8
    {:square, address + 1, layer + 1, 0, layer_width + 2, next_layer_after, 1, layer_width + 1}
  end
  def next_square_after({:square, address, layer, index_in_layer, layer_width, next_layer_after, _, 1}) do
    {:square, address + 1, layer, index_in_layer + 1, layer_width, next_layer_after, 0, layer_width}
  end
  def next_square_after({:square, address, layer, index_in_layer, layer_width, next_layer_after, from_last_corner, to_next_corner}) do
    {:square, address + 1, layer, index_in_layer + 1, layer_width, next_layer_after, from_last_corner + 1, to_next_corner - 1}
  end

  def distance({:square, 1, _, _, _, _, _}), do: 0
  def distance({:square, _, layer, _, _, _, from_last_corner, to_next_corner}) do
    abs(from_last_corner - to_next_corner)
    |> div(2)
    |> Kernel.+(layer - 1)
  end
end
