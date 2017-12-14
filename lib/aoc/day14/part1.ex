defmodule Aoc.Day14.Part1 do
  alias Aoc.Day10.Part2

  def num_ones(input) do
    input |> grid |> Enum.map(&Enum.sum/1) |> Enum.sum
  end

  def grid(input) do
    Enum.map(0..127, fn(i) ->
      input <> "-#{i}"
      |> Part2.run |> hex_to_bin
    end)
  end

  def hex_to_bin(input)
  def hex_to_bin(<<a>> <> rest) do
    {integer, ""} = Integer.parse(<<a>>, 16)
    bin = Integer.digits(integer, 2) |> lpad(4)
    bin ++ hex_to_bin(rest)
  end
  def hex_to_bin(<<>>), do: []

  def lpad(list, to) when length(list) == to, do: list
  def lpad(list, to), do: lpad([0 | list], to)

  def count_ones(bits), do: Enum.count(bits, fn(x) -> x end)
end
