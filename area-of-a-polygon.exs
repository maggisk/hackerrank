# https://www.hackerrank.com/challenges/lambda-march-compute-the-area-of-a-polygon/problem
# score: 20/20

defmodule Shoelace do
  def polygon_area(points) do
    area = points
    |> Enum.zip(tl(points) ++ [hd(points)])
    |> Enum.reduce(0, fn({{x1, y1}, {x2, y2}}, area) -> area + x1 * y2 - x2 * y1 end)
    abs(area) / 2
  end

  def main() do
    {n, _} = IO.read(:line) |> Integer.parse
    1..n
    |> Enum.map(fn(_) -> IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1) |> List.to_tuple end)
    |> polygon_area
    |> IO.puts
  end
end

Shoelace.main()
