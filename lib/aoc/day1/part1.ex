defmodule Aoc.Day1.Part1 do
  def captcha(digit_string) do
    digits = String.graphemes(digit_string) |> Enum.map(&String.to_integer/1)
    inner_captcha(digits)
  end

  def inner_captcha(digits), do: inner_captcha(digits, [])
  def inner_captcha([first, second | rest], remains) when first == second do
    first + inner_captcha([second | rest], remains ++ [first])
  end
  def inner_captcha([first, second | rest], remains), do: inner_captcha([second | rest], remains ++ [first])
  def inner_captcha([first], [other_first | _remains]) when first == other_first, do: first
  def inner_captcha([_first], [_other_first | _remains]), do: 0
end
