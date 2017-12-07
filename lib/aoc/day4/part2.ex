defmodule Aoc.Day4.Part2 do
  def num_valid(passwords_string) do
    passwords_string
    |> String.split("\n")
    |> Enum.count(&valid?/1)
  end

  @doc """
  Returns whether the password is valid

  ## Examples

  iex> Part2.valid?("abcde fghij")
  true
  iex> Part2.valid?("abcde xyz ecdab")
  false
    
  """
  def valid?(password) do
    split = String.split(password, " ")
    sorted = split
      |> Enum.map(&(String.split(&1, "")))
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&Enum.join/1)

    Enum.count(sorted) == Enum.count(Enum.uniq(sorted))
  end
end
