defmodule Aoc.Day23.Part1 do
  require Record

  def preprocess(input), do: input |> String.trim |> String.split("\n") |> Enum.map(&preprocess_row/1)
  def preprocess_row(row), do: row |> String.trim |> String.split(" ")

  @initial_registers Enum.map(?a..?h, fn(_) -> 0 end)
  Record.defrecord :machine, state: :running, registers: @initial_registers, send_queue: [], receive_queue: [], program: [], program_past: []

  def num_muls(simulation_stream) do
    simulation_stream
    |> Stream.filter(fn(machine(program: [[ins | _] | _],)) ->
      ins == "mul"
    end)
    |> Enum.count
  end

  def simulation_stream(instructions) do
    Stream.iterate(machine(program: instructions), &step/1)
    |> Stream.take_while(&(machine(&1, :state) == :running))
  end

  def step(machine = machine(state: :halted)), do: machine
  def step(machine = machine(program: [])), do: machine(machine, state: :halted)
  def step(machine = machine(program: [instruction | rest], state: :running, program_past: past)) do
    machine(machine, program_past: [instruction | past], program: rest)
    |> step(instruction)
    |> maybe_halted
  end
  def step(machine = machine(program: [])), do: machine(machine, state: :halted)

  def step(machine = machine(registers: registers), ["set", a, b]) do
    registers = List.replace_at(registers, register_index(a), value(machine, b))
    machine(machine, registers: registers)
  end

  def step(machine = machine(registers: registers), ["sub", a, b]) do
    registers = List.update_at(registers, register_index(a), &(&1 - value(machine, b)))
    machine(machine, registers: registers)
  end

  def step(machine = machine(registers: registers), ["mul", a, b]) do
    registers = List.update_at(registers, register_index(a), &(&1 * value(machine, b)))
    machine(machine, registers: registers)
  end

  def step(machine = machine(program: program, program_past: past), ["jnz", a, b]) do
    case {value(machine, a), value(machine, b)} do
      {iff, _} when iff == 0 -> machine
      {_, jump} when jump < 0 ->
        {moved, rest} = Enum.split(past, 1 - jump)
        machine(machine, program: Enum.reverse(moved) ++ program, program_past: rest)
      {_, jump} when jump > 0 ->
        {moved, rest} = Enum.split(program, jump - 1)
        machine(machine, program: rest, program_past: Enum.reverse(moved) ++ past)
    end
  end

  def maybe_halted(machine = machine(program: [])), do: machine(machine, state: :halted)
  def maybe_halted(machine = machine()), do: machine

  def value(machine(registers: registers), spec = <<char>>) when char in ?a..?z, do: Enum.at(registers, register_index(spec))
  def value(_machine, spec), do: spec |> String.to_integer

  def register_index(<<register_name>>) when register_name in ?a..?z, do: register_name - ?a
end
