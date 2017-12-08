defmodule Aoc.Day3.Part2 do
  alias Aoc.Day3.Part1
  use Bitwise

  def first_greater_than(n) do
    natural_numbers()
    |> Stream.map(&value/1)
    |> Stream.drop_while(fn(val) -> val <= n end)
    |> Enum.take(1)
    |> List.first
  end

  def value(1), do: 1
  def value(square) do
    indices_for(square)
    |> Enum.map(&value/1)
    |> Enum.sum
  end

  @doc """
  Returns the indices from which the given square is built

  ## Examples

  iex> Part2.indices_for(10) |> Enum.sort
  [2, 9]
  iex> Part2.indices_for(11) |> Enum.sort
  [2, 3, 9, 10]
  iex> Part2.indices_for(17) |> Enum.sort
  [5, 16]
  iex> Part2.indices_for(18) |> Enum.sort
  [5, 6, 16, 17]
  iex> Part2.indices_for(24) |> Enum.sort
  [8, 9, 10, 23]
  """
  def indices_for(2), do: [1]
  def indices_for(square) do
    # TODO: this is repeated everywhere
    layer_number = Part1.layer_number(square)
    # widest point
    layer_width = (2 * layer_number) + 1

    distance_from_start = square - Part1.first_in_layer(layer_number)
    first_in_layer = 0 == distance_from_start
    from_last_corner = 1 + rem(distance_from_start, layer_width - 1)
    to_next_corner = (layer_width - 1) - from_last_corner
    to_next_layer = Part1.first_in_layer(layer_number + 1) - square

    indices = [inner_index(square), square - 1]

    if is_corner(square) do
      case to_next_layer do
        1 -> [inner_index(square) + 1 | indices]
        _ -> indices
      end
    else
      indices = case first_in_layer == false && (to_next_corner  != 1 || to_next_layer <= 2) do
        true -> [inner_index(square) + 1 | indices] 
        false -> indices
      end

      indices = case from_last_corner != 1 && distance_from_start > 1 do
        true -> [inner_index(square) - 1 | indices] 
        false -> indices
      end

      indices = case distance_from_start == 1 || (from_last_corner == 1 && distance_from_start > 1) do
        true -> [square - 2 | indices] 
        false -> indices
      end

      indices
    end
  end

  def inner_index(square) when square > 1 do
    layer_number = Part1.layer_number(square)
    # widest point
    layer_width = (2 * layer_number) + 1

    distance_from_start = square - Part1.first_in_layer(layer_number)
    first_in_layer = distance_from_start == 0
    corners_passed = div(distance_from_start, layer_width - 1)
    previous_layer_length = 2 * ((layer_width - 2) + (layer_width - 4))

    remove = cond do
      first_in_layer ->
        0
      is_corner(square) ->
        2
      true ->
        1
    end

    square - (previous_layer_length + (2 * corners_passed)) - remove
  end

  def is_corner(square) when square > 1 do
    layer_number = Part1.layer_number(square)
    # widest point
    layer_width = (2 * layer_number) + 1

    distance_from_start = square - Part1.first_in_layer(layer_number)
    from_last_corner = 1 + rem(distance_from_start, layer_width - 1)
    to_next_corner = (layer_width - 1) - from_last_corner

    to_next_corner == 0
  end

  def layer_size(layer_n) do
    (8 * layer_n * (layer_n+1)) >>> 1
  end

  defp natural_numbers do
    Stream.iterate(1, &(&1 + 1))
  end
end
