defmodule Aoc.Day2.Part1 do
  def checksum(spreadsheet) do
    String.split(spreadsheet, "\n")
    |> Enum.map(&line_to_numbers/1)
    |> Enum.map(&delta/1)
    |> Enum.sum
  end

  defp line_to_numbers(line) do
    String.split(line, "\s")
    |> Enum.map(&String.to_integer/1)
  end

  defp delta(numbers) do
    Enum.max(numbers) - Enum.min(numbers)
  end
end
