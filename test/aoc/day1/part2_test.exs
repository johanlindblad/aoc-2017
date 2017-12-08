defmodule Aoc.Day1.Part2Test do
  use ExUnit.Case
  alias Aoc.Day1.Part2

  test "1212 produces 6" do
    assert Part2.captcha("1212") == 6
  end

  test "1221 produces 0" do
    assert Part2.captcha("1221") == 0
  end

  test "123425 produces 4" do
    assert Part2.captcha("123425") == 4
  end

  test "123123 produces 12" do
    assert Part2.captcha("123123") == 12
  end

  test "12131415 produces 4" do
    assert Part2.captcha("12131415") == 4
  end

  test "puzzle input produces 1188" do
    assert Part2.captcha(Aoc.puzzle_input(1)) == 1188
  end
end
