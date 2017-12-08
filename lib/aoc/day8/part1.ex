defmodule Aoc.Day8.Part1 do
  def parse(input) do
    String.trim(input) |> String.split("\n") |> Enum.map(&parse_row/1)
  end

  def parse_row(row), do: String.split(row) |> clean

  def simulate(instructions), do: simulate(instructions, %{})
  def simulate([], registers), do: Map.values(registers) |> Enum.max
  def simulate([instruction | rest], registers) do
    [register, operation, operand | _] = instruction

    registers = case check_cond(instruction, registers) do
      true -> registers_after(registers, register, operation, operand)
      false -> registers
    end

    simulate(rest, registers)
  end

  def registers_after(registers, reg, op, opa) do
    current = registers[reg] || 0
    Map.put(registers, reg, operation(current, op, opa))
  end

  def check_cond([_, _, _, reg, op, val], registers) do
    Map.get(registers, reg, 0) |> inner_cond(op, val)
  end
  def inner_cond(val, :>, other), do: val > other
  def inner_cond(val, :<, other), do: val < other
  def inner_cond(val, :>=, other), do: val >= other
  def inner_cond(val, :<=, other), do: val <= other
  def inner_cond(val, :==, other), do: val == other
  def inner_cond(val, :!=, other), do: val != other

  def operation(val, :inc, by), do: val + by
  def operation(val, :dec, by), do: val - by

  def clean([reg, op, opa, "if", con_reg, con_op, con_val]) do
    [String.to_atom(reg), String.to_atom(op), String.to_integer(opa), String.to_atom(con_reg), String.to_atom(con_op), String.to_integer(con_val)]
  end
end
