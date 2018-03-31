# https://www.hackerrank.com/challenges/pascals-triangle/problem
# score: 10 of 10

defmodule Pas do
  def get(x, y) when x <= 0 or y <= 0 or y >= x, do: 1
  def get(x, y), do: get(x - 1, y - 1) + get(x - 1, y)

  def draw(n) do
    for row <- 0..(n - 1) do
      0..(row) |> Enum.map(&(get(row, &1))) |> Enum.join(" ") |> IO.puts
    end
  end
end

Pas.draw(IO.read(:line) |> String.trim |> String.to_integer)
