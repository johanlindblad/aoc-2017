defmodule Aoc.Day1.Part1 do
  def captcha(digits) do
    length = String.length(digits)
    split = 
      String.split(digits, "")
      |> Enum.reject(fn(c) -> String.length(c) == 0 end)
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(0..(length-1), 0, fn(i, acc) ->
      if Enum.at(split, i) == Enum.at(split, rem(i+1, length)) do
        acc + Enum.at(split, i)
      else
        acc
      end
    end)
  end
end
