# https://www.hackerrank.com/challenges/messy-medians/problem
# score: 80/80

defmodule MessyMedians do
  defmodule State do
    defstruct [
      median: nil,
      smaller: {0, :gb_trees.empty},
      larger: {0, :gb_trees.empty},
    ]
  end

  # this is way faster than Integer.parse !?
  def parse_int(<<?-, rest::binary>>) do
    -_parse_int(rest, 0)
  end
  def parse_int(b) do
    _parse_int(b, 0)
  end
  def _parse_int(<<c, rest::binary>>, i) when ?0 <= c and c <= ?9 do
    _parse_int(rest, i * 10 + (c - ?0))
  end
  def _parse_int(_, i) do
    i
  end

  def process_line(line, history) do
    state = event(history, parse_int(line))
    :array.set(:array.size(history), state, history)
  end

  def event(history, n) when n < 0 do
    :array.get(:array.size(history) + n, history)
  end
  def event(history, n) do
    case :array.size(history) do
      0 ->
        %State{median: n}
      _ ->
        :array.get(:array.size(history) - 1, history)
          |> insert(n)
          |> balance
    end
  end

  def insert(%{median: m} = state, n) when n < m do
    adjust(state, :smaller, n, 1)
  end
  def insert(state, n) do
    adjust(state, :larger, n, 1)
  end

  def adjust(state, side, key, change) do
    Map.update!(state, side, fn({n, tree}) ->
      tree =
        case :gb_trees.lookup(key, tree) do
          {:value, current} when current + change == 0 ->
            :gb_trees.delete(key, tree)
          {:value, current} when current + change > 0 ->
            :gb_trees.update(key, current + change, tree)
          :none when change > 0 ->
            :gb_trees.insert(key, change, tree)
        end
      {n + change, tree}
    end)
  end

  def balance(state) do
    %{smaller: {n_smaller, smaller}, larger: {n_larger, larger}} = state
    case n_smaller - n_larger do
      +1 -> swap(state, :smaller, :larger, :gb_trees.largest(smaller))
      -2 -> swap(state, :larger, :smaller, :gb_trees.smallest(larger))
      _  -> state
    end
  end

  def swap(state, from_side, to_side, {new_median, _}) do
    state
      |> adjust(from_side, new_median, -1)
      |> adjust(to_side, state.median, 1)
      |> Map.put(:median, new_median)
  end

  def main() do
    IO.read(:line)
    history = Enum.reduce(IO.binstream(:stdio, :line), :array.new, &process_line/2)
    :array.foldr(fn(_, state, acc) -> [state.median | acc] end, [], history)
      |> Enum.join("\n")
      |> IO.puts
  end
end

MessyMedians.main()
