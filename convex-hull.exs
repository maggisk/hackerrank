# https://www.hackerrank.com/challenges/convex-hull-fp/problem
# score: 30 of 30

defmodule ConvexHull do
  def get_x({x, _}), do: x

  def convex_hull(points) do
    points_l2r = points |> Enum.sort
    points_r2l = points_l2r |> Enum.reverse
    path_l2r = points_l2r |> Enum.uniq_by(&get_x/1) |> convex_path(hd(points_r2l))
    path_r2l = points_r2l |> Enum.uniq_by(&get_x/1) |> convex_path(hd(points_l2r))
    path_l2r ++ tl(path_r2l)
  end

  defp convex_path(points, endpoint, acc \\ [])
  defp convex_path([], endpoint, [endpoint | _] = acc), do: acc
  defp convex_path([], endpoint, acc), do: [endpoint | acc]
  defp convex_path([{x3, y3} = p3 | points], endpoint, [{x2, y2} = p2, {x1, y1} = p1 | acc]) do
    p2_y_cutoff = (x2 - x1) / (x3 - x1) * (y3 - y1) + y1
    case (x1 < x3 and y2 >= p2_y_cutoff) or (x1 > x3 and y2 <= p2_y_cutoff) do
      true  -> convex_path([p3 | points], endpoint, [p1 | acc])
      false -> convex_path(points, endpoint, [p3, p2, p1 | acc])
    end
  end
  defp convex_path([p | points], endpoint, acc), do: convex_path(points, endpoint, [p | acc])

  def dist({x1, y1}, {x2, y2}), do: :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))

  def hull_size(points, sum \\ 0)
  def hull_size([_], sum), do: sum
  def hull_size([p1, p2 | points], sum), do: hull_size([p2 | points], sum + dist(p1, p2))

  def read_ints(), do: IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1)

  def main() do
    [n] = read_ints()
    1..n
    |> Enum.map(fn(_) -> read_ints() |> List.to_tuple end)
    |> convex_hull
    |> hull_size
    |> IO.puts
  end
end

ConvexHull.main()
