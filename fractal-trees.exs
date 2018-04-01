# https://www.hackerrank.com/challenges/fractal-trees/problem
# score: 30 of 30

defmodule FractalTrees do
  @cols 100
  @rows 63

  def is_Y(n, x, y) do
    is_Y(n, div(@cols, 2) - 1, 0, 32, x, @rows - y - 1)
  end

  def is_Y(n, center, bottom, height, x, y) do
    cond do
      n <= 0 ->
        false
      y < bottom + div(height, 2) ->
        x == center
      y < bottom + height ->
        abs(center - x) - 1 == rem(y, div(height, 2))
      true ->
        is_Y(n - 1, center - div(height, 2), bottom + height, div(height, 2), x, y) or
        is_Y(n - 1, center + div(height, 2), bottom + height, div(height, 2), x, y)
    end
  end

  def pick_char(true),  do: "1"
  def pick_char(false), do: "_"

  def draw(n) do
    Enum.each(0..(@rows - 1), fn(y) ->
      0..(@cols - 1)
      |> Enum.map(&(is_Y(n, &1, y)))
      |> Enum.map(&pick_char/1)
      |> Enum.join
      |> IO.puts
    end)
  end
end

FractalTrees.draw(IO.read(:line) |> String.trim |> String.to_integer)
