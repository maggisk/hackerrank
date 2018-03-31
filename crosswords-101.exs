# https://www.hackerrank.com/challenges/crosswords-101/problem
# score: 30 of 30

defmodule Crossword do
  @height 10
  @width 10

  def lines_to_charmap(lines) do
    for {line, y} <- Enum.with_index(lines), {c, x} <- Enum.with_index(to_charlist(line)), into: Map.new, do: {{x, y}, c}
  end

  def match_words(holes, words) do
    _match(holes, words, Map.new)
  end

  def _match([], [], occupied), do: occupied
  def _match([], _, _), do: nil
  def _match(holes, [word | words], occupied) do
    Enum.find_value(holes, fn(hole) ->
      case _update_word(hole, word, occupied) do
        nil ->
          _match(List.delete(holes, hole), [word | words], occupied)
        more_occupied ->
          _match(List.delete(holes, hole), words, more_occupied)
      end
    end)
  end

  def _update_word([], [], occupied), do: occupied
  def _update_word([point | points], [char | chars], occupied) do
    case occupied[point] do
      nil -> _update_word(points, chars, Map.put(occupied, point, char))
      ^char -> _update_word(points, chars, occupied)
      _other -> nil
    end
  end
  def _update_word(_, _, _), do: nil

  def find_holes(charmap) do
    vertical = charmap
      |> Enum.sort_by(fn({point, _}) -> point end)
      |> Enum.chunk_by(fn({{x, _}, c}) -> {x, c} end)
    horizontal = charmap
      |> Enum.sort_by(fn({{x, y}, _}) -> {y, x} end)
      |> Enum.chunk_by(fn({{_, y}, c}) -> {y, c} end)
    (vertical ++ horizontal)
      |> Enum.filter(fn([{_, c}|tail]) -> c == ?- and tail != [] end)
      |> Enum.map(fn(holes) -> Enum.map(holes, &(elem(&1, 0))) end)
  end

  def draw(occupied) do
    for y <- 0..(@height - 1) do
      for x <- 0..(@width - 1) do
        Map.get(occupied, {x, y}, "+")
      end |> Enum.join |> IO.puts
    end
  end

  def main(lines, words) do
    lines
      |> lines_to_charmap
      |> find_holes
      |> match_words(words)
      |> draw()
  end
end

Crossword.main(
  0..9 |> Enum.map(fn(_) -> IO.read(:line) |> String.trim end),
  IO.read(:line) |> String.trim |> String.split(";") |> Enum.map(&String.codepoints/1)
)
