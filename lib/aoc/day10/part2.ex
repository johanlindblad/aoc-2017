defmodule Aoc.Day10.Part2 do
  alias Aoc.Day10.Part1
  use Bitwise

  def run(input_string) do
    instructions = input_string <> <<17, 31, 73, 47, 23>> |> :binary.bin_to_list
    rounds(Enum.to_list(0..255), instructions, 64)
    |> sparse_to_dense
    |> dense_to_hex
  end

  def rounds(bytes, instructions, rounds, position \\ 0, skip \\ 0)
  def rounds(bytes, _instructions, 0, position, _), do: Part1.rotate(bytes, -position)
  def rounds(bytes, instructions, rounds, position, skip) do
    {bytes, position, skip, _} = hash_round(bytes, instructions, position, skip)
    rounds(bytes, instructions, rounds - 1, position, skip)
  end

  def hash_round(bytes, instructions, position, skip, length \\ 256) do
    Part1.hash(bytes, length, instructions, position, skip)
  end

  def sparse_to_dense(bytes) do
    bytes
    |> Enum.chunk_every(16)
    |> Enum.map(&xor_chunk/1)
    |> :binary.list_to_bin
  end

  @doc """
  Performs XOR on the given chunk

  ## Example

  iex> Part2.xor_chunk([65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22])
  64
    
  """
  def xor_chunk(chunk) do
    Enum.reduce(chunk, &(&1 ^^^ &2))
  end

  @doc """
  Converts the dense hash to a hexadecimal string

  ## Example

  iex> Part2.dense_to_hex(<<64, 7, 255>>)
  "4007ff"
    
  """

  def dense_to_hex(dense) do
    Base.encode16(dense, case: :lower)
  end
end
