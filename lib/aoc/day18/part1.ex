defmodule Aoc.Day18.Part1 do
  require Record

  def preprocess(input), do: input |> String.trim |> String.split("\n") |> Enum.map(&preprocess_row/1)
  def preprocess_row(row), do: row |> String.trim |> String.split(" ")

  @initial_registers Enum.map(?a..?z, fn(_) -> 0 end)
  Record.defrecord :machine, state: :running, registers: @initial_registers, send_queue: [], receive_queue: [], first_received: nil, program: [], program_past: []

  def first_received(instructions) do
    instructions
    |> loopback_stream
    |> Enum.find(fn (machine(first_received: val)) -> val != nil end)
    |> machine(:first_received)
  end

  def loopback_stream(instructions) do
    simulation_stream(instructions, fn
      (machine = machine(send_queue: [])) -> machine
      (machine = machine(send_queue: snd, receive_queue: rcv)) ->
        machine(machine, send_queue: [], receive_queue: Enum.reverse(snd) ++ rcv)
    end)
  end

  def simulation_stream(instructions, transform \\ fn(machine) -> machine end) do
    Stream.iterate(machine(program: instructions), &(transform.(&1) |> step))
  end

  def step(machine = machine(program: [instruction | rest], state: :running, program_past: past)) do
    machine(machine, program_past: [instruction | past], program: rest)
    |> step(instruction)
  end
  def step(machine = machine(program: [])), do: machine(machine, state: :halted)
  def simulate(machine = machine(state: :halted), _), do: machine

  def step(machine = machine(registers: registers), ["set", a, b]) do
    registers = List.replace_at(registers, register_index(a), value(machine, b))
    machine(machine, registers: registers)
  end

  def step(machine = machine(registers: registers), ["add", a, b]) do
    registers = List.update_at(registers, register_index(a), &(&1 + value(machine, b)))
    machine(machine, registers: registers)
  end

  def step(machine = machine(registers: registers), ["mul", a, b]) do
    registers = List.update_at(registers, register_index(a), &(&1 * value(machine, b)))
    machine(machine, registers: registers)
  end

  def step(machine = machine(registers: registers), ["mod", a, b]) do
    registers = List.update_at(registers, register_index(a), &(rem(&1, value(machine, b))))
    machine(machine, registers: registers)
  end

  def step(machine = machine(program: program, program_past: past), ["jgz", a, b]) do
    case {value(machine, a), value(machine, b)} do
      {iff, _} when iff <= 0 -> machine
      {_, jump} when jump < 0 ->
        {moved, rest} = Enum.split(past, 1 - jump)
        machine(machine, program: Enum.reverse(moved) ++ program, program_past: rest)
      {_, jump} when jump > 0 ->
        {moved, rest} = Enum.split(program, jump - 1)
        machine(machine, program: rest, program_past: Enum.reverse(moved) ++ past)
    end
  end

  def step(machine = machine(send_queue: queue), ["snd", a]) do
    machine(machine, send_queue: [value(machine, a) | queue])
  end

  def step(machine = machine(first_received: first, registers: registers, receive_queue: queue), ["rcv", a]) do
    case value(machine, a) do
      0 -> machine
      _ -> 
        [rcv | rest] = queue
        registers = List.replace_at(registers, register_index(a), rcv)
        machine(machine, first_received: (first || rcv), receive_queue: rest, registers: registers)
    end
  end

  def value(machine(registers: registers), spec = <<char>>) when char in ?a..?z, do: Enum.at(registers, register_index(spec))
  def value(_machine, spec), do: spec |> String.to_integer

  def register_index(<<register_name>>) when register_name in ?a..?z, do: register_name - ?a
end
