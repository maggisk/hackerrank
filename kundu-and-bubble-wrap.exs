defmodule Kundu do
  def calc(total), do: calc(total, total, 0)
  def calc(_, 0, sum), do: sum
  def calc(total, left, sum), do: calc(total, left - 1, sum + total / left)
end

IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1) |> Enum.reduce(&(&1 * &2)) |> Kundu.calc |> IO.puts
