defmodule Aoc.Day1.Part2 do
  def captcha(digits) do
    length = String.length(digits)
    half_length = div(length, 2)

    split = 
      String.split(digits, "")
      |> Enum.reject(fn(c) -> String.length(c) == 0 end)
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(0..(length-1), 0, fn(i, acc) ->
      if Enum.at(split, i) == Enum.at(split, rem(i + half_length, length)) do
        acc + Enum.at(split, i)
      else
        acc
      end
    end)
  end
end
