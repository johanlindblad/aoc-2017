defmodule Aoc.Day11.Part1 do
  def solve(input) when is_binary(input) do
    input |> preprocess |> walk |> distance
  end
  def preprocess(input) when is_binary(input), do: String.trim(input) |> String.split(",")

  def walk(steps, coordinates \\ {0, 0})
  def walk(["n" | steps], {x, y}), do: walk(steps, {x, y + 2})
  def walk(["s" | steps], {x, y}), do: walk(steps, {x, y - 2})
  def walk(["ne" | steps], {x, y}), do: walk(steps, {x + 1, y + 1})
  def walk(["se" | steps], {x, y}), do: walk(steps, {x + 1, y - 1})
  def walk(["sw" | steps], {x, y}), do: walk(steps, {x - 1, y - 1})
  def walk(["nw" | steps], {x, y}), do: walk(steps, {x - 1, y + 1})
  def walk([], {x, y}), do: {x, y}

  def distance({0, 0}), do: 0
  def distance({0, y}), do: div(y, 2) |> abs
  def distance({x, y}) do
    1 + distance({x - sgn(x), y - sgn(y)})
  end

  defp sgn(n) when n < 0, do: -1
  defp sgn(_), do: 1
end
