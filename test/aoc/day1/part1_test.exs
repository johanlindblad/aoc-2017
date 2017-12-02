defmodule Aoc.Day1.Part1Test do
  use ExUnit.Case
  alias Aoc.Day1.Part1

  test "1122 produces 3" do
    assert Part1.captcha("1122") == 3
  end

  test "1111 produces 4" do
    assert Part1.captcha("1111") == 4
  end

  test "1234 produces 4" do
    assert Part1.captcha("1234") == 0
  end

  test "91212129" do
    assert Part1.captcha("91212129") == 9
  end
end
