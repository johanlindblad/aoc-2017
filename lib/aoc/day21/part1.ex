defmodule Aoc.Day21.Part1 do
  @initial [[0,1,0],[0,0,1],[1,1,1]]

  def parse_transformations(input) do
    String.trim(input) |> String.split("\n") |> Enum.map(&parse_row/1)
    |> Enum.into(%{})
    |> add_variations
  end
  def parse_row(row) do
    String.split(row, " => ") |> Enum.map(&parse_pattern/1) |> List.to_tuple
  end

  def on_after(patterns, steps) do
    grid_stream(patterns) |> Enum.at(steps) |> elem(0) |> num_squares
  end

  def num_squares(grid) do
    grid |> Enum.map(&Enum.sum/1) |> Enum.sum
  end

  def grid_stream({grid, width} \\ {@initial, 3}, patterns) do
    Stream.iterate({grid, width}, fn({grid, width}) ->
      new_grid = iterate({grid, width}, patterns)
      new_width = new_grid |> List.first |> length
      {new_grid, new_width}
    end)
  end

  def print_stream(patterns, interval \\ 500) do
    Stream.zip(Stream.interval(interval), grid_stream(patterns))
    |> Stream.each(fn({_, {grid, width}}) ->
      IEx.Helpers.clear

      padding = List.duplicate(" ", div(324 - width, 2))
      vertical_padding = List.duplicate(" ", div(324 - width, 2))

      IO.puts(vertical_padding)

      grid
      |> Enum.map(fn(row) -> Enum.map(row, &(Enum.at([" ", "█"], &1))) end)
      |> Enum.map(fn(str) -> padding ++ str end)
      |> Enum.each(&IO.puts/1)
    end)
  end

  def iterate({grid, width}, patterns) do
    cond do
      rem(width, 2) == 0 -> iterate({grid, width}, patterns, 2)
      rem(width, 3) == 0 -> iterate({grid, width}, patterns, 3)
    end
  end

  def iterate({grid, width}, patterns, chunk_size) do
    per_row = div(width, chunk_size)
    chunks = grid |> grid_to_chunks(chunk_size)
    transformed = chunks |> Enum.flat_map(&(Map.fetch!(patterns, &1)))

    # Chunk the list of squares into chunks of 3 or 4 rows (which is the number
    # of rows in one transformation), take as many of these as there will be per
    # row of output and then transpose and flatten these to get the new output
    # grid
    transformed |> Enum.chunk_every(chunk_size+1) |> Enum.chunk_every(per_row) |> Enum.flat_map(&transpose/1) |> Enum.map(&List.flatten/1)
  end

  # Gives a list of chunks, which need to be mapped and then re-chunked to
  # restore the grid
  def grid_to_chunks(grid, chunk_width) do
    grid |> Enum.chunk_every(chunk_width) |> Enum.flat_map(&(chunk_row_chunk(&1, chunk_width)))
  end
  def chunk_row_chunk(row_chunk, chunk_width) do
    row_chunk |> Enum.map(&(Enum.chunk_every(&1, chunk_width))) |> transpose
  end

  def all_variations(pattern) do
    Stream.cycle([:transpose, :rotate]) |> Enum.take(8)
    |> Enum.reduce([pattern], fn
      (:transpose, [head | tail]) -> [transpose(head), head | tail]
      (:rotate, [head | tail]) -> [Enum.reverse(head), head | tail]
    end)
  end

  def add_variations(patterns) do
    Enum.reduce(Map.keys(patterns), patterns, fn(from, patterns) ->
      to = patterns[from]
      Enum.reduce(all_variations(from), patterns, fn(pattern, patterns) ->
        Map.put(patterns, pattern, to)
      end)
    end)
  end

  def parse_pattern(coordinates \\ [[]], pattern, row \\ 0, column \\ 0)
  def parse_pattern([current | tail], <<char>> <> pattern, row, column) do
    coordinates = case <<char>> do
      "." -> [current ++ [0] | tail]
      "#" -> [current ++ [1] | tail]
      "/" -> [[], current | tail]
    end

    parse_pattern(coordinates, pattern, row, column)
  end
  def parse_pattern(grid, "", _, _), do: Enum.reverse(grid)

  def transpose(list), do: list |> List.zip |> Enum.map(&Tuple.to_list/1)
end
