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
    table
    |> coordinate_stream
    |> Stream.map(fn({x, y}) -> table[{x,y}] end)
    |> Stream.filter(fn(<<char>>) -> char in ?A..?Z end)
    |> Enum.join("")
  end

  def coordinate_stream(table), do: Stream.map(walk_stream(table), fn({coord, _}) -> coord end)

  def walk_stream(table) do
    Stream.iterate({start_index(table), {0, 1}}, fn({coords, direction}) ->
      walk(table, coords, direction)
    end)
    |> Stream.take_while(fn({_, direction}) -> direction != {0, 0} end)
  end

  def start_index(table = %{}, _candidate = {x,0} \\ {0, 0}) do
    case table[{x, 0}] do
      "|" -> {x, 0}
      _ -> start_index(table, {x + 1, 0})
    end
  end

  def walk(table, coordinate, direction \\ {0, 1})
  def walk(table = %{}, {x, y}, {xd, yd}) when x >= 0 and y >= 0 do
    {xd, yd} = cond do
      can_walk?(table[{x+xd,y+yd}]) -> {xd, yd}
      can_walk?(table[{x+yd,y+xd}]) -> {yd, xd}
      can_walk?(table[{x-yd,y-xd}]) -> {-yd, -xd}
      true -> {0, 0}
    end

    {{x+xd, y+yd}, {xd, yd}}
  end

  def can_walk?( <<char>>) when char in ?A..?Z, do: true
  def can_walk?(pipe) when pipe in ["|", "-", "+"], do: true
  def can_walk?(_), do: false

  def visualization_stream(table, interval \\ 500) do
    Stream.zip(Stream.interval(interval), coordinate_stream(table))
    |> Stream.each(fn({_, {x, y}}) ->
      IEx.Helpers.clear

      Enum.map(y-20..y+20, fn(yy) ->
        Enum.reduce(x-20..x+20, "\n", fn(xx, row) ->
          cond do
            {x, y} == {xx, yy} -> row <> "#"
            true -> row <> (table[{xx,yy}] || " ")
          end
        end)
      end)
      |> IO.puts
    end)
  end

  def filled_input(table) do
    coordinate_stream(table)
    |> Stream.scan(table_to_grid(table), fn({x,y}, grid) -> 
      List.update_at(grid, y, fn(row) -> 
        List.replace_at(row, x, '█')
      end)
    end)
    |> Stream.zip(Stream.interval(25))
    |> Stream.each(fn({grid, _}) -> 
      IEx.Helpers.clear
      IO.puts(grid)
    end)
  end

  defp table_to_grid(table) do
    Map.keys(table) |> Enum.sort_by(fn({x,y}) -> {y,x} end) |> Enum.chunk_by(&(elem(&1, 1)))
    |> Enum.map(fn(row) -> (row |> Enum.map(&(Map.get(table, &1)))) ++ ["\n"] end)
    |> Enum.map(&to_charlist/1)
  end
end
