defmodule Aoc.Day4.Part1 do
  def num_valid(passwords_string) do
    passwords_string
    |> String.split("\n")
    |> Enum.count(&valid?/1)
  end

  @doc """
  Returns whether the password is valid

  ## Examples

  iex> Part1.valid?("aa bb cc dd ee")
  true
  iex> Part1.valid?("aa bb cc dd aa")
  false
    
  """
  def valid?(password) do
    split = String.split(password, " ")

    Enum.count(split) == Enum.count(Enum.uniq(split))
  end
end
