# https://www.hackerrank.com/challenges/swap-nodes/problem
# score: 40 of 40

defmodule SwapNodes do
  def create_tree(node_id_pairs) do
    {{:value, root}, _} = [[1] | node_id_pairs] |> Enum.concat |> Enum.reverse |> to_tree |> :queue.out
    root
  end

  defp to_tree(node_ids, q \\ :queue.new)
  defp to_tree([], q), do: q
  defp to_tree([id | node_ids], q) do
    {node, q} = id_to_node(id, q)
    q = :queue.in(node, q)
    to_tree(node_ids, q)
  end

  def id_to_node(-1, q), do: {nil, q}
  def id_to_node(id, q) do
    {{:value, right}, q} = :queue.out(q)
    {{:value, left}, q}  = :queue.out(q)
    {{id, left, right}, q}
  end

  def swap(root, k, depth \\ 1)
  def swap(nil, _, _), do: nil
  def swap({id, left, right}, k, depth) do
    {left, right} = case rem(depth, k) do
      0 -> {right, left}
      _ -> {left, right}
    end
    {id, swap(left, k, depth + 1), swap(right, k, depth + 1)}
  end

  def collect_ids(node), do: collect_ids(node, []) |> Enum.reverse
  def collect_ids(nil, acc), do: acc
  def collect_ids({id, left, right}, acc) do
    acc = collect_ids(left, acc)
    acc = [id | acc]
    collect_ids(right, acc)
  end

  def main() do
    {n, _} = IO.binread(:line) |> Integer.parse
    tree = 1..n
      |> Enum.map(fn(_) -> IO.read(:line) |> String.split |> Enum.map(&String.to_integer/1) end)
      |> create_tree
    {t, _} = IO.binread(:line) |> Integer.parse
    Enum.reduce(1..t, tree, fn(_, tree) ->
      {k, _} = IO.binread(:line) |> Integer.parse
      tree = swap(tree, k)
      tree |> collect_ids |> Enum.join(" ") |> IO.puts
      tree
    end)
  end
end

SwapNodes.main()
