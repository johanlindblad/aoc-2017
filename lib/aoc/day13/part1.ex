defmodule Aoc.Day13.Part1 do
  def solve(input) do
    input |> preprocess |> travel |> Enum.map(&tuple_product/1) |> Enum.sum 
  end

  def preprocess(input) do
    input |> String.trim |> String.split("\n") |> Enum.map(&preprocess_row/1)
  end
  def preprocess_row(row) do
    [l, d] = row |> String.split(": ") |> Enum.map(&String.to_integer/1)
    {l, d}
  end

  def travel(layers, initial_delay \\ 0) do
    Enum.filter(layers, &(caught_at(&1, initial_delay)))
  end

  # A layer with n depth takes n steps to the bottom and then n - 2 steps
  # until it gets back up
  def caught_at(layer_def, delay \\ 0)
  def caught_at({layer, depth}, delay), do: rem(layer + delay, (depth*2) - 2) == 0

  defp tuple_product({a,b}), do: a * b
end
