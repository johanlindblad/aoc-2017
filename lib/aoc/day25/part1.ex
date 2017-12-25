defmodule Aoc.Day25.Part1 do
  def parse(input) do
    input 
    |> String.trim 
    |> String.split("\n")
    |> Enum.map(&(String.trim_trailing(&1, ":")))
    |> Enum.map(&(String.trim_trailing(&1, ".")))
    |> Enum.map(&String.trim_leading/1)
    |> parse_lines(%{})
  end

  def diagnostic_checksum(instructions) do
    simulate(instructions) |> Enum.at(instructions.steps) |> elem(4)
  end

  def simulate(instructions) do
    Stream.iterate({instructions.state, [], [], instructions, 0}, &step/1)
  end

  def step({state, [front | front_rest], [back | back_rest], instructions, num_ones}) do
    {write_val, dir, next_state} = instructions[state] |> elem(front)
    diff = write_val - front

    {tape_back, tape_front} = case dir do
      "right" -> {[write_val, back | back_rest], front_rest}
      "left" -> {back_rest, [back, write_val | front_rest]}
    end

    {next_state, tape_front, tape_back, instructions, num_ones + diff}
  end

  # Feed more of the infinite tape when needed...
  def step({state, [], tape_back, instructions, num_ones}) do
    step({state, [0], tape_back, instructions, num_ones})
  end
  def step({state, tape_front, [], instructions, num_ones}) do
    step({state, tape_front, [0], instructions, num_ones})
  end

  def parse_lines([], params), do: params
  def parse_lines(["" | tail], params), do: parse_lines(tail, params)

  def parse_lines(["Begin in state " <> s | tail], %{}) do
    parse_lines(tail, %{state: s})
  end

  def parse_lines(["Perform a diagnostic checksum after " <> rest | tail], params = %{}) do
    num = String.split(rest, " ") |> List.first |> String.to_integer
    parse_lines(tail, Map.put(params, :steps, num))
  end

  def parse_lines(["In state " <> state | tail], params) do
    {if_zero, tail} = parse_in_state(tail)
    {if_one, tail} = parse_in_state(tail)
    params = Map.put(params, state, {if_zero, if_one})

    parse_lines(tail, params)
  end

  def parse_in_state([
    "If the current value is " <> _,
    "- Write the value " <> val,
    "- Move one slot to the " <> dir,
    "- Continue with state " <> state | tail]) do
    {{String.to_integer(val), dir, state}, tail}
  end
end
