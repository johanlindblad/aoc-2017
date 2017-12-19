defmodule Aoc.Day18.Part2 do
  import Aoc.Day18.Part1, only: [machine: 1, machine: 2, register_index: 1]
  alias Aoc.Day18.Part1

  def one_sends(simulation_stream) do
    Stream.transform(simulation_stream, 0, fn
      ({machine(receive_queue: []), _}, acc) -> {[], acc}
      ({machine(receive_queue: queue), _}, acc) -> 
        size = length(queue)
        {[acc + size], acc + size}
    end)
    |> Enum.at(-1)
  end

  def simulation_stream(instructions) do
    machine1 = machine(program: instructions)
    machine2 = machine1 |> step(["set", "p", "1"])
    initial = {machine1, machine2}

    Stream.iterate(initial, &simulate/1)
    |> Stream.take_while(
      fn({machine(state: a), machine(state: b)}) ->
        a == :running || b == :running
    end)
  end

  def simulate({m1 = machine(state: :running), m2}), do: {step(m1), m2} |> sync_queues
  def simulate({m1 = machine(state: :waiting), m2 = machine(state: :running)}), do: {m1, step(m2)} |> sync_queues
  
  def sync_queues({m1 = machine(send_queue: [s1 | st1]), m2 = machine(receive_queue: [], state: :waiting)}) do
    sync_queues({
      machine(m1, send_queue: []),
      machine(m2, receive_queue: [s1 | st1], state: :running)
    })
  end
  def sync_queues({m1 = machine(receive_queue: [], state: :waiting), m2 = machine(send_queue: [s2 | st2])}) do
    sync_queues({
      machine(m1, receive_queue: [s2 | st2], state: :running),
      machine(m2, send_queue: [])
    })
  end
  def sync_queues({m1, m2}), do: {m1, m2}

  def step(machine = machine(program: [instruction | rest], state: :running, program_past: past)) do
    machine(machine, program_past: [instruction | past], program: rest)
    |> step(instruction)
  end

  # If the queue is empty, indicate that we are waiting for input
  def step(machine = machine(receive_queue: [], program: program, program_past: [_ | rest]), ["rcv", a]) do
    machine(machine, state: :waiting, program: [["rcv", a] | program], program_past: rest)
  end
  def step(machine = machine(registers: registers, receive_queue: [rcv | rest]), ["rcv", a]) do
    registers = List.replace_at(registers, register_index(a), rcv)
    machine(machine, receive_queue: rest, registers: registers)
  end

  defdelegate step(machine, ins), to: Part1
end
