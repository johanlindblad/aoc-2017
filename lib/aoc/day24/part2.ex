defmodule Aoc.Day24.Part2 do
  def solve({map, initial_state}), do: max_score([initial_state], map)

  # state = {remaining, score, port}
  def max_score(state_list, map) do
    next_states = Enum.reduce(state_list, [], fn({remaining, score, port}, next_states) ->
      extra = Enum.filter(map[port], fn(other) -> 
        MapSet.member?(remaining, other)
      end)
      |> Enum.map(fn({a,b}) ->
        contact_score = a + b
        remaining = MapSet.delete(remaining, {a,b})
        {remaining, score + contact_score, contact_score - port}
      end)

      extra ++ next_states
    end)

    case next_states do
      [] -> Enum.max_by(state_list, fn({_,score,_}) -> score end) |> elem(1)
      _ -> max_score(next_states, map)
    end
  end
end
