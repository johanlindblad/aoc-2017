defmodule Aoc.Day9.Part2 do
  def parse(string) when is_binary(string), do: parse(String.trim(string) |> String.graphemes, 0)

  def parse(["{" | rest], garbage), do: parse(rest, garbage)
  def parse(["}" | rest], garbage), do: parse(rest, garbage)
  def parse(["," | rest], garbage), do: parse(rest, garbage)
  def parse(["" | rest], garbage), do: parse(rest, garbage)
  def parse(["<" | rest], garbage), do: garbage(rest, garbage)
  def parse([], garbage), do: garbage

  def garbage([">" | rest], garbage), do: parse(rest, garbage)
  def garbage(["!", _ | rest], garbage), do: garbage(rest, garbage)
  def garbage([_ | rest], garbage), do: garbage(rest, garbage + 1)
end
