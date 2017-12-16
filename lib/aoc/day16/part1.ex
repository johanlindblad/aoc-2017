defmodule Aoc.Day16.Part1 do
  import Aoc.Day10.Part1, only: [rotate: 2]
  def start(), do: [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p]

  def preprocess(input), do: input |> String.trim |> String.split(",")

  def run(instructions, programs \\ start()) do
    Enum.reduce(instructions, programs, &perform/2)
  end
  def perform("s" <> rest, programs), do: spin(programs, String.to_integer(rest))
  def perform("x" <> rest, programs) do
    [first, second] = rest |> String.split("/") |> Enum.map(&String.to_integer/1)
    exchange(programs, first, second)
  end
  def perform("p" <> rest, programs) do
    [first, second] = rest |> String.split("/") |> Enum.map(&String.to_atom/1)
    partner(programs, first, second)
  end

  def spin(programs, steps), do: rotate(programs, -steps)

  def exchange(programs, i1, i2) do
    value1 = Enum.at(programs, i1)
    value2 = Enum.at(programs, i2)
    programs |> List.replace_at(i1, value2) |> List.replace_at(i2, value1)
  end

  def partner(programs, value1, value2) do
    i1 = Enum.find_index(programs, &(&1 == value1))
    i2 = Enum.find_index(programs, &(&1 == value2))

    programs |> exchange(i1, i2)
  end
end
