defmodule Aoc.Day9.Part1 do
  def parse(string) when is_binary(string), do: parse(String.trim(string) |> String.split(""), 1)
  def parse(["{" | rest], level) do
    level + parse(rest, level + 1)
  end

  def parse(["}" | rest], level), do: parse(rest, level - 1)
  def parse(["<" | rest], level), do: garbage(rest, level)
  def parse(["," | rest], level), do: parse(rest, level)
  def parse(["" | rest], level), do: parse(rest, level)
  def parse([], _level), do: 0

  def garbage(["!", _ | rest], level), do: garbage(rest, level)
  def garbage([">" | rest], level), do: parse(rest, level)
  def garbage([_ | rest], level), do: garbage(rest, level)
end
