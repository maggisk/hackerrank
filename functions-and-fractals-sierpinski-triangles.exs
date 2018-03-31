# https://www.hackerrank.com/challenges/functions-and-fractals-sierpinski-triangles/problem
# score: 30 of 30

defmodule Sierpinski do
  @rows 32
  @cols 63

  def create_triangle(set, _x, _y, width, _move_y) when width <= 0, do: set
  def create_triangle(set, x, y, width, move_y) do
    (for i <- 0..(width - 1), into: set, do: {x - div(width, 2) + i, y})
      |> create_triangle(x, y + move_y, width - 2, move_y)
  end

  def gaps(set, 0, _, _, _), do: set
  def gaps(set, n, x, y, width) do
    set
      |> create_triangle(x, y, width, 1)
      |> gaps(n - 1, x - div(width, 2) - 1, y + div(width, 4) + 1, div(width, 2))
      |> gaps(n - 1, x + div(width, 2) + 1, y + div(width, 4) + 1, div(width, 2))
      |> gaps(n - 1, x, y - div(width, 4) - 1, div(width, 2))
  end

  def draw(set) do
    pick_char = %{true: "1", false: "_"}
    for y <- 0..(@rows - 1) do
      for x <- 0..(@cols - 1) do
        pick_char[MapSet.member?(set, {x, y})]
      end |> Enum.join
    end |> Enum.join("\n") |> IO.puts
  end

  def main(n) do
    MapSet.new
      |> create_triangle(div(@cols, 2), @rows - 1, @cols, -1)
      |> MapSet.difference(gaps(MapSet.new, n, div(@cols, 2), div(@rows, 2), div(@cols, 2)))
      |> draw()
  end
end

Sierpinski.main(IO.gets("") |> String.trim |> String.to_integer)
