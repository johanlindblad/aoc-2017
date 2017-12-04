defmodule Aoc.Day2.Part2 do
  def checksum(spreadsheet) do
    String.split(spreadsheet, "\n")
    |> Enum.map(&line_to_numbers/1)
    |> Enum.map(&even_division/1)
    |> Enum.sum
  end

  defp line_to_numbers(line) do
    String.split(line, "\s")
    |> Enum.map(&String.to_integer/1)
  end

  defp even_division([head | tail]) do
    check = fn(number) -> result(head, number) != nil end
    div = Enum.find(tail, check)

    if div do
      result(div, head)
    else
      even_division(tail)
    end
  end

  defp result(numerator, denominator) when numerator < denominator do
    result(denominator, numerator)
  end

  defp result(numerator, denominator) do
    if rem(numerator, denominator) == 0 do
      div(numerator, denominator)
    end
  end
end

