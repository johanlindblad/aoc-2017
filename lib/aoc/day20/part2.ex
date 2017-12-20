defmodule Aoc.Day20.Part2 do
  # TODO: sort by time and avoid having dead particles collide in the future
  def particles_left(particles) do
    set = MapSet.new(particles)

    left = Enum.reduce(set, set, fn(particle, left) ->
      rest = MapSet.delete(set, particle)
      collides_with = Enum.filter(rest, &(collide_at(&1, particle))) |> MapSet.new()

      case MapSet.size(collides_with) do
        0 -> left
        _ -> MapSet.delete(left, particle)
      end
    end)

    MapSet.size(left)
  end

  def collide_at(p1, p2) do
    # Once for each direction (x, y, z)
    times = Enum.flat_map(0..2, fn(i) ->
      collision_points(extract_component(p1, i), extract_component(p2, i)) end)
    |> Enum.filter(fn(t) -> 
      position(p1, t) == position(p2, t)
    end)

    case times do
      [] -> nil
      _ -> times |> Enum.min
    end
  end

  @doc """
  Returns the (integer) times when the given particle components will collide.

  If they never collide it returns [] and if they collide at all points it will
  also return []

  ## Examples:
  
  iex> Part2.collision_points([5, 5, 0], [0, 10, 0])
  [1]
  iex> Part2.collision_points([5, 5, 0], [0, 7, 0])
  []
  iex> Part2.collision_points([0, 10, 0], [0, 25, 30])
  [0]
  iex> Part2.collision_points([5, 10, 0], [0, 0, 15])
  [1]
  iex> Part2.collision_points([30, 20, 0], [0, 10, 10])
  [3]
  iex> Part2.collision_points([-6, 3, 0], [-4, 2, 0])
  [2]
  """
  def collision_points(p1 = [_x1, _v1, _a1], p2 = [_x2, _v2, _a2]) do
    collision_candidates(p1, p2)
    |> Enum.filter(&(&1 >= 0))
    |> Enum.filter(&(position(p1, &1) == position(p2, &1)))
  end

  @doc """
  Gives candidates for times at which the given particles will collide
  They will be rounded to the nearest integer which means that they will
  need to be verified to actually be solutions
  """
  def collision_candidates([x1, v1, a1], [x2, v2, a2]) do
    # Coefficients for the quadratic equation (for twice the distance)
    {a1, b1, c1} = {a1, (2*v1) + a1, 2 * x1}
    {a2, b2, c2} = {a2, (2*v2) + a2, 2 * x2}
    {a, b, c} = {a2-a1, b2-b1, c2-c1}

    b2_4ac = (b*b - 4*a*c)

    cond do
      # Same acceleration and speed, no solutions or always solved depending
      # on initial position
      a == 0 && b == 0 -> []
      # Same acceleration, solved by (p2-p1) + (p2-p1)t = 0
      a == 0 && rem(c, b) == 0 -> [div(-c, b)]
      a == 0 && rem(c, b) != 0 -> []

      # Quadratic formula indicates no solutions
      b2_4ac < 0 -> []

      # Quadratic formula indicates only one solution
      b2_4ac == 0 -> [div(-b, 2*a)]

      # Quadratic formula indicates two possible solutions
      b2_4ac > 0 ->
        root = :math.sqrt(b2_4ac) |> round
        first_root = div(-b + root, 2*a)
        second_root = div(-b - root, 2*a)
        [first_root, second_root]
    end
  end

  def position(particle = [p, _v, _a], t) when is_tuple(p) do
    Enum.map(0..2, &(extract_component(particle, &1)))
    |> Enum.map(&(position(&1, t)))
  end
  def position([p, v, a], t) do
    p + (v*t) + (a*div(t*t + t, 2))
  end

  defp extract_component(particle, index), do: Enum.map(particle, &elem(&1, index))
end
