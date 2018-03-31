# https://www.hackerrank.com/challenges/puzzle-and-pc/problem
# progress: 100%

defmodule PandP do
  def combinations(xs, ys) do
    for x <- xs, y <- ys, do: {x, y}
  end

  def solve(n, left_upper \\ {1, 1}, occupied, acc \\ [])

  def solve(2, {left, upper}, occupied, acc) do
    piece = combinations(left..(left + 1), upper..(upper + 1)) |> List.delete(occupied)
    [piece | acc]
  end

  def solve(n, {left, upper}, {x_o, y_o} = occupied, acc) do
    n = div(n, 2)
    quadrants = combinations([left, left + n], [upper, upper + n])
    squares =
      combinations([left + n - 1, left + n], [upper + n - 1, upper + n])
      |> Enum.map(fn({x, y}) ->
        case div(x_o - left, n) == div(x - left, n) and div(y_o - upper, n) == div(y - upper, n) do
          true  -> occupied
          false -> {x, y}
        end
      end)
    acc =
      Enum.zip(quadrants, squares)
      |> Enum.reduce(acc, fn({left_upper, sqr}, acc) ->
        solve(n, left_upper, sqr, acc)
      end)
    [List.delete(squares, occupied) | acc]
  end

  def print(solution) do
    Enum.each(solution, fn(piece) ->
      piece |> Enum.sort |> Enum.flat_map(&Tuple.to_list/1) |> Enum.join(" ") |> IO.puts
    end)
  end

  def main() do
    m = IO.read(:line) |> String.trim |> String.to_integer
    n = :math.pow(2, m) |> round
    [x, y] = IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1)
    solve(n, {x, y}) |> print
  end
end

PandP.main()
