defmodule Aoc.Day19.Part1 do
  def parse(input) do
    lines = input |> String.split("\n")
    lines |> Enum.with_index |> Enum.map(&parse_row/1) |> List.flatten |> Enum.into(%{})
  end
  def parse_row({row, y}) do
    chars = row |> String.graphemes
    chars |> Enum.with_index |> Enum.map(fn({char, x}) -> {{x, y}, char} end)
  end

  def collected(table) do
    table |> walk_stream |> Enum.at(-1) |> elem(2) |> Enum.reverse |> Enum.join("")
  end

  def start_index(table = %{}, _candidate = {x,0} \\ {0, 0}) do
    case table[{x, 0}] do
      "|" -> {x, 0}
      _ -> start_index(table, {x + 1, 0})
    end
  end

  def walk_stream(table) do
    Stream.iterate({start_index(table), {0, 1}, []}, fn({coords, direction, collected}) ->
      walk(table, coords, direction, collected)
    end)
    |> Stream.take_while(fn({_, direction, _}) -> direction != {0, 0} end)
  end

  def walk(table, coordinate, direction \\ {0, 1}, collected \\ [])
  def walk(table = %{}, {x, y}, {xd, yd}, collected) when x >= 0 and y >= 0 do
    {xd, yd} = cond do
      can_walk?(table, {x,y}, {xd, yd}) -> {xd, yd}
      can_walk?(table, {x, y}, {yd, xd}) -> {yd, xd}
      can_walk?(table, {x, y}, {-yd, -xd}) -> {-yd, -xd}
      true -> {0, 0}
    end

    collected = case table[{x+xd, y+yd}] do
      letter = <<char>> when char in ?A..?Z -> [letter | collected]
      _ -> collected
    end

    {{x+xd, y+yd}, {xd, yd}, collected}
  end

  def can_walk?(table, {x, y}, {xd, yd}) do
    case table[{x+xd, y+yd}] do
      pipe when pipe in ["|", "-", "+"] -> true
      _letter = <<code>> when code in ?A..?Z -> true
      _ -> false
    end
  end

  def expected_char_for({0, _yd}), do: "|"
  def expected_char_for({_xd, 0}), do: "-"

  def vizualization_stream(table, interval \\ 500) do
    text_stream = walk_stream(table)
    |> Stream.map(fn({{x, y}, _, _}) ->
      Enum.map(y-10..y+10, fn(yy) ->
        Enum.map(x-10..x+10, fn(xx) ->
          cond do
            {x, y} == {xx, yy} -> "#"
            true -> (table[{xx,yy}] || " ")
          end
        end)
        |> Enum.join("")
      end) |> Enum.join("\n")
    end)

    Stream.interval(interval)
    |> Stream.transform(text_stream, fn(_, text_stream) ->
      {Enum.take(text_stream, 1), Stream.drop(text_stream, 1)}
    end)
    |> Stream.each(fn(_) -> IEx.Helpers.clear end)
    |> Stream.each(&IO.puts/1)
  end
end
