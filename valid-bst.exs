# https://www.hackerrank.com/challenges/valid-bst/problem
# score: 20/20

defmodule ValidBST do
  def is_valid_tree(values, root \\ -1, stack \\ [])
  def is_valid_tree([], _, _), do: "YES"
  def is_valid_tree([v | _], root, _) when v < root, do: "NO"
  def is_valid_tree([v | _] = values, _, [s | stack]) when s < v, do: is_valid_tree(values, s, stack)
  def is_valid_tree([v | values], root, stack), do: is_valid_tree(values, root, [v | stack])

  def main() do
    {n, _} = IO.read(:line) |> Integer.parse
    1..n |> Enum.each(fn(_) ->
      IO.read(:line) # ignore
      IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1) |> is_valid_tree |> IO.puts
    end)
  end
end

ValidBST.main()
