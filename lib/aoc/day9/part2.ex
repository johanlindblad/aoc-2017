defmodule Aoc.Day9.Part2 do
  import Aoc.Day9.Part1
  def garbage_count(string), do: elem(parse(string), 1)
end
