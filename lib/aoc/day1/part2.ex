defmodule Aoc.Day1.Part2 do
  def captcha(digit_string) do
    digits = String.graphemes(digit_string) |> Enum.map(&String.to_integer/1)
    half_length = Enum.count(digits) |> div(2)
    inner_captcha(digits, Enum.drop(digits, half_length))
  end 

  def inner_captcha([], _), do: 0
  def inner_captcha([first | rest], [other_first | other_rest]) when first == other_first do
    first + inner_captcha(rest, other_rest ++ [first])
  end
  def inner_captcha([first | rest], [other_first | other_rest]), do: inner_captcha(rest, other_rest ++ [first])
end
