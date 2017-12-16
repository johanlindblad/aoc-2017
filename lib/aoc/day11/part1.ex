defmodule Aoc.Day11.Part1 do
  def solve(input) when is_binary(input) do
    input |> preprocess |> walk |> distance
  end
  def preprocess(input) when is_binary(input), do: String.trim(input) |> String.split(",")
  def walk(steps), do: steps |> Enum.map(&effect/1) |> Enum.reduce(&sum/2)
 
  def effect("n"), do: {0, 2}
  def effect("s"), do: {0, -2}
  def effect("ne"), do: {1, 1}
  def effect("se"), do: {1, -1}
  def effect("sw"), do: {-1, -1}
  def effect("nw"), do: {-1, 1}

  def distance({x, y}) when x < 0 or y < 0, do: distance({abs(x), abs(y)})
  def distance({0, y}), do: div(y, 2)
  def distance({x, y}) when y <= x, do: x
  def distance({x, y}), do: div(x+y, 2)

  def sum({a, b}, {c, d}), do: {a + c, b + d}
end
