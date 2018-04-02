# https://www.hackerrank.com/challenges/super-digit/problem
# score: 20 of 20

defmodule SuperDigit do
  def superdigit(n, k), do: superdigit(digitsum(n) * k)
  def superdigit(n) when n < 10, do: n
  def superdigit(n), do: superdigit(digitsum(n))

  def digitsum(n), do: _digitsum(Integer.to_string(n))
  defp _digitsum(b, sum \\ 0)
  defp _digitsum(<<>>, sum), do: sum
  defp _digitsum(<<c, rest::binary>>, sum), do: _digitsum(rest, sum + (c - ?0))

  def main() do
    [n, k] = IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1)
    superdigit(n, k) |> IO.puts
  end
end

SuperDigit.main()
