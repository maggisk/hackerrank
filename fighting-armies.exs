# https://www.hackerrank.com/challenges/fighting-armies/problem
# score: 60 of 60

defmodule Armies do
  @space 32
  def parse(line, v \\ 0, acc \\ [])
  def parse(<<>>, v, acc), do: Enum.reverse([v|acc])
  def parse("\n", v, acc), do: parse("", v, acc)
  def parse(<<@space, rest::binary>>, v, acc), do: parse(rest, 0, [v|acc])
  def parse(<<c, rest::binary>>, v, acc), do: parse(rest, v * 10 + (c - ?0), acc)

  def insert(l, v, acc \\ [])
  def insert([h|t], v, acc) when h > v, do: insert(t, v, [h|acc])
  def insert(l, v, acc), do: Enum.reverse(acc, [v|l])

  def merge(as, bs, acc \\ [])
  def merge([a|as], [b|bs], acc) when a >= b, do: merge(as, [b|bs], [a|acc])
  def merge([a|as], [b|bs], acc), do: merge([a|as], bs, [b|acc])
  def merge([], bs, acc), do: Enum.reverse(acc, bs)
  def merge(as, [], acc), do: Enum.reverse(acc, as)

  def event(line, armies) do
    case parse(line) do
      [1, i] ->
        IO.puts(hd(:array.get(i, armies)))
        armies
      [2, i] ->
        :array.set(i, tl(:array.get(i, armies)), armies)
      [3, i, c] ->
        :array.set(i, insert(:array.get(i, armies), c), armies)
      [4, i, j] ->
        :array.set(j, [], :array.set(i, merge(:array.get(i, armies), :array.get(j, armies)), armies))
    end
  end

  def main() do
    {n, _} = IO.read(:line) |> Integer.parse
    armies = :array.new(n + 1, {:default, []})
    Enum.reduce(IO.binstream(:stdio, :line), armies, &event/2)
  end
end

Armies.main()
