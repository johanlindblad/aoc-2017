defmodule Aoc.Day8.Part2 do
  alias Aoc.Day8.Part1
  defdelegate parse(input), to: Part1

  def simulate(instructions), do: simulate(instructions, %{}, 0)
  def simulate([], _registers, max_so_far), do: max_so_far
  def simulate([instruction | rest], registers, max_so_far) do
    [register, operation, operand | _] = instruction

    registers_after = Part1.registers_after(registers, register, operation, operand)

    registers = case Part1.check_cond(instruction, registers) do
      true -> registers_after
      false -> registers
    end

    value = Map.get(registers, register, 0)

    simulate(rest, registers, max(max_so_far, value))
  end
end
