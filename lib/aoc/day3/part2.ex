defmodule Aoc.Day3.Part2 do
  alias Aoc.Day3.Part1
  require Aoc.Day3.Part1
  use Bitwise

  defmacro is_last_in_layer(s) do
    quote do
      elem(unquote(s), Part1.square(:address)) == elem(unquote(s), Part1.square(:next_layer_after))
      #Part1.square(unquote(s), :address) == Part1.square(unquote(s), :next_layer_after)
    end
  end
  defmacro is_next_to_last(s) do
    quote do
      Part1.square(unquote(s), :address) + 1 == Part1.square(unquote(s), :next_layer_after)
    end
  end
  defmacro is_first_in_layer(square), do: quote do: Part1.square(unquote(square), :index_in_layer) == 0
  defmacro is_second_in_layer(square), do: quote do: Part1.square(unquote(square), :index_in_layer) == 1
  defmacro is_corner(square), do: quote do: Part1.square(unquote(square), :from_last_corner) == 0
  defmacro is_first_after_corner(square), do: quote do: Part1.square(unquote(square), :from_last_corner) == 1
  defmacro is_first_before_corner(square), do: quote do: Part1.square(unquote(square), :to_next_corner) == 1

  def first_greater_than(n) do
    Part1.squares
    |> Stream.drop(1)
    |> Stream.map(&relative_indices/1)
    |> Enum.reduce_while([1], fn (offsets, acc) ->
        case (Enum.map(offsets, &Enum.at(acc, -&1 - 1)) |> Enum.sum) do
          val when val > n -> {:halt, val}
          val -> {:cont, [val | acc]}
        end
    end)
  end

  def values(n) do
    Part1.squares
    |> Stream.map(&relative_indices/1)
    |> Enum.take(n)
    |> Enum.drop(1)
    |> Enum.reduce([1], fn (offsets, acc) ->
        acc ++ [(Enum.map(offsets, &Enum.at(acc, &1)) |> Enum.sum)]
    end)
  end

  def relative_indices(Part1.square(address: 1)), do: []
  def relative_indices(Part1.square(address: 2)), do: [-1]
  def relative_indices(sq = Part1.square()) do
    adjacent_offsets(sq) ++ inner_offsets(sq) ++ start_of_layer_offset(sq)
    |> Enum.uniq
  end

  def adjacent_offsets(Part1.square(index_in_layer: index)) when index == 0, do: [-1]
  def adjacent_offsets(Part1.square(from_last_corner: from_corner)) when from_corner == 1, do: [-1, -2]
  def adjacent_offsets(Part1.square(index_in_layer: index)) when index == 1, do: [-1, -2]
  def adjacent_offsets(_), do: [-1]

  def inner_offsets(sq) when is_corner(sq), do: [inner_offset(sq)]
  def inner_offsets(sq = Part1.square(layer: 2)), do: [inner_offset(sq)]
  def inner_offsets(sq) when is_first_in_layer(sq), do: [inner_offset(sq)]
  def inner_offsets(sq) when is_first_after_corner(sq), do: [inner_offset(sq), inner_offset(sq) + 1]
  def inner_offsets(sq) when is_first_before_corner(sq), do: [inner_offset(sq), inner_offset(sq) - 1]
  def inner_offsets(sq) when is_second_in_layer(sq), do: [inner_offset(sq), inner_offset(sq) + 1]
  def inner_offsets(sq), do: [inner_offset(sq) + 1, inner_offset(sq), inner_offset(sq) - 1]

  def start_of_layer_offset(sq) when is_last_in_layer(sq), do: [first_in_layer_offset(sq)]
  def start_of_layer_offset(sq) when is_next_to_last(sq), do: [first_in_layer_offset(sq)]
  def start_of_layer_offset(_), do: []

  def start_of_last_layer_offset(sq) when is_first_in_layer(sq), do: [first_in_layer_offset(sq)]

   def inner_offset(s = Part1.square()) when is_corner(s) do
    -(4 * inner_layer_width(s)) - (2 * corners_passed(s)) - 2
  end
  def inner_offset(s = Part1.square()) when is_first_in_layer(s) do
    -(4 * inner_layer_width(s)) - (2 * corners_passed(s))
  end
  def inner_offset(s = Part1.square()) do
    -(4 * inner_layer_width(s)) - (2 * corners_passed(s)) - 1
  end

  def first_in_layer_offset(Part1.square(index_in_layer: index)), do: -index
  def corners_passed(Part1.square(index_in_layer: index, layer_width: width)), do: div(index, width)
  def inner_layer_width(Part1.square(layer_width: width)), do: width - 2
end
