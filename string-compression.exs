# https://www.hackerrank.com/challenges/string-compression
# score: 10 of 10

defmodule Comp do
  def ress(<<a, a, rest::binary>>, acc, c), do: ress(<<a, rest::binary>>, acc, c + 1)
  def ress(<<a, rest::binary>>, acc, 1), do: ress(rest, [<<a>> | acc], 1)
  def ress(<<a, rest::binary>>, acc, n), do: ress(rest, ["#{<<a>>}#{n}" | acc], 1)
  def ress(<<>>, acc, _), do: acc |> Enum.reverse |> Enum.join
end

IO.gets("")
|> String.trim
|> Comp.ress([], 1)
|> IO.puts
