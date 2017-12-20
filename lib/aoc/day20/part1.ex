defmodule Aoc.Day20.Part1 do
  def parse(input), do: input |> String.trim |> String.split("\n") |> Enum.map(&parse_row/1)
  def parse_row(row) do
    row |> String.split([",", "=", "<", ">", " "]) |> Enum.map(&maybe_int/1) |> List.flatten
    |> Enum.chunk_every(3) |> Enum.map(&List.to_tuple/1)
  end

  def maybe_int(string) do
    case Integer.parse(string) do
      {n, _} -> [n]
      :error -> []
    end
  end

  # TODO: not correct in general case
  # use math similar to path 2
  def closest_long_term(particles) do
    {_particle, index} = particles |> Enum.with_index |> Enum.min_by(fn
      ({[p, v, a], _i}) -> {manhattan(a), manhattan(v), manhattan(p)}
    end)

    index
  end

  def manhattan({x, y, z}), do: abs(x) + abs(y) + abs(z)
end
