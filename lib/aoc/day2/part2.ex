defmodule Aoc.Day2.Part2 do
  alias Aoc.Day2.Part1
  defdelegate line_to_numbers(line), to: Part1

  def checksum(spreadsheet) do
    String.trim(spreadsheet)
    |> String.split("\n")
    |> Enum.map(&line_to_numbers/1)
    |> Enum.map(&even_division/1)
    |> Enum.sum
  end

  defp even_division([_first]), do: false
  defp even_division([first, second | tail]) do
    cond do
      rem(first, second) == 0 -> div(first, second)
      rem(second, first) == 0 -> div(second, first)
      true -> even_division([first | tail]) || even_division([second | tail])
    end
  end
end

