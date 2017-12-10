defmodule Aoc.Day3.Part2 do
  alias Aoc.Day3.Part1
  require Aoc.Day3.Part1
  use Bitwise

  def relative_indices, do: Part1.squares |> Stream.map(&relative_indices/1)
  def values, do: relative_indices() |> Stream.transform([], &value_accumulator/2)
  def first_greater_than(n), do: values() |> Stream.drop_while(&(&1 < n)) |> Enum.at(0)

  # Emits {[emitted elements], [accumulated previous squares]}
  def value_accumulator(_, []), do: {[1], [1]}
  def value_accumulator(offsets, previous_values) do
    val = (Enum.map(offsets, &Enum.at(previous_values, -&1 - 1)) |> Enum.sum)
    {[val], [val | previous_values]}
  end

  def relative_indices(Part1.square(address: 1)), do: []
  def relative_indices(Part1.square(address: 2)), do: [-1]
  def relative_indices(sq = Part1.square()) do
    adjacent_offsets(sq) ++ inner_offsets(sq) ++ start_of_layer_offset(sq)
    |> Enum.uniq
  end

  def adjacent_offsets(Part1.square(from_start: 0)), do: [-1]
  def adjacent_offsets(Part1.square(from_corner: 1)), do: [-1, -2]
  def adjacent_offsets(Part1.square(from_start: 1)), do: [-1, -2]
  def adjacent_offsets(_), do: [-1]

  def inner_offsets(sq = Part1.square(from_corner: 0)), do: [inner_offset(sq)]
  def inner_offsets(sq = Part1.square(layer: 2)), do: [inner_offset(sq)]
  def inner_offsets(sq = Part1.square(from_start: 0)), do: [inner_offset(sq)]
  def inner_offsets(sq = Part1.square(from_start: 1)), do: [inner_offset(sq) - 1, inner_offset(sq)]
  def inner_offsets(sq = Part1.square(to_corner: 1)), do: [inner_offset(sq) - 1, inner_offset(sq)]
  def inner_offsets(sq = Part1.square(from_corner: 1)), do: [inner_offset(sq), inner_offset(sq) + 1]
  def inner_offsets(sq), do: [inner_offset(sq) - 1, inner_offset(sq), inner_offset(sq) + 1]

  def start_of_layer_offset(Part1.square(to_next_layer: 1, from_start: index)), do: [-index]
  def start_of_layer_offset(Part1.square(to_next_layer: 2, from_start: index)), do: [-index]
  def start_of_layer_offset(_), do: []

   def inner_offset(s = Part1.square()) do
    -(4 * inner_layer_width(s)) - (2 * corners_passed(s)) - inner_offset_extra(s)
  end
  defp inner_offset_extra(Part1.square(from_corner: 0)), do: 2
  defp inner_offset_extra(Part1.square(from_start: 0)), do: 0
  defp inner_offset_extra(Part1.square(from_start: 1)), do: 0
  defp inner_offset_extra(_), do: 1

  def corners_passed(Part1.square(from_start: index, layer_width: width)), do: div(index, width)
  def inner_layer_width(Part1.square(layer_width: width)), do: width - 2
end
