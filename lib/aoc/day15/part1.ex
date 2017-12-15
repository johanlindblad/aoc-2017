defmodule Aoc.Day15.Part1 do
  use Bitwise

  def parse(file_input), do: file_input |> String.trim |> String.split("\n") |> Enum.map(&parse_row/1)
  def parse_row("Generator " <> <<_::binary-size(1)>> <> " starts with " <> number) do
    String.to_integer(number)
  end

  def solve(input = [_a_first, _b_first]), do: number_streams(input) |> num_equal

  def number_streams([a_first, b_first]) do
    {number_stream(a_first, 16807, 2147483647), number_stream(b_first, 48271, 2147483647)}
  end

  def num_equal({a_stream, b_stream}, pairs \\ 40_000_000) do
    Stream.zip(a_stream, b_stream)
    |> Stream.take(pairs)
    |> Stream.filter(fn({a, b}) -> matches_last_16_bits?(a, b) end)
    |> Enum.count
  end

  def number_stream(first_value, factor, modulo) do
    Stream.iterate(first_value, &(next_value(&1, factor, modulo)))
    |> Stream.drop(1)
  end

  @doc """
  Returns the next value for the generator

  ## Examples

  iex> Part1.next_value(65, 16807, 2147483647)
  1092455
  iex> Part1.next_value(1181022009, 16807, 2147483647)
  245556042
    
  """
  def next_value(last_value, factor, modulo) do
    rem(last_value * factor, modulo)
  end

  def matches_last_16_bits?(number_a, number_b) do
    lower_16_bits(number_a) == lower_16_bits(number_b)
  end

  defp lower_16_bits(number) do
    number &&& (65535)
  end
end
