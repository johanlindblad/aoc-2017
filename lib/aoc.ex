defmodule Aoc do
  @moduledoc """
  Documentation for Aoc.
  """

  def puzzle_input(day) do
    {:ok, contents} = Path.join(:code.priv_dir(:aoc), "day#{day}.txt")
                      |> File.read

    contents
  end
end
