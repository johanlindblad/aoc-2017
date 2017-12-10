defmodule Aoc.Day9.Part1 do
  def score(string), do: elem(parse(string), 0)

  def parse(string, level \\ 1, score \\ 0, garbage \\ 0)
  def parse("{" <> rest, level, score, garbage), do: parse(rest, level + 1, score + level, garbage)
  def parse("}" <> rest, level, score, garbage), do: parse(rest, level - 1, score, garbage)
  def parse("," <> rest, level, score, garbage), do: parse(rest, level, score, garbage)
  def parse("<" <> rest, level, score, garbage), do: garbage(rest, level, score, garbage)
  def parse("\n" <> rest, level, score, garbage), do: parse(rest, level, score, garbage)
  def parse("", _, score, garbage), do: {score, garbage}

  def garbage(">" <> rest, level, score, garbage), do: parse(rest, level, score, garbage)
  def garbage("!" <> rest, level, score, garbage), do: escaped(rest, level, score, garbage)
  def garbage(<<_>> <> rest, level, score, garbage), do: garbage(rest, level, score, garbage + 1)

  def escaped(<<_>> <> rest, level, score, garbage), do: garbage(rest, level, score, garbage)
end
