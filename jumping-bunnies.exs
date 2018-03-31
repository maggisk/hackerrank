# https://www.hackerrank.com/challenges/jumping-bunnies/problem
# score: 20 of 20

defmodule Bunnies do
  def common_ground(jump_dist, current_dist) do
    div(jump_dist * current_dist, gcd(jump_dist, current_dist))
  end

  def gcd(0, y), do: y
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  def main() do
    IO.read(:line)
    IO.read(:line)
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&common_ground/2)
    |> IO.puts
  end
end

Bunnies.main()
