import Aoc

aoc 2023, 1 do
  alias Aoc.Utils

  def p1(input \\ Utils.get_input(2023, 1)) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.replace(&1, ~r/[[:alpha:]]/, ""))
    |> Enum.map(fn s ->
      cond do
        String.length(s) > 1 ->
          [0, -1] |> Enum.map(&String.at(s, &1)) |> Enum.join() |> String.to_integer()

        true ->
          String.to_integer("#{s}#{s}")
      end
    end)
    |> Enum.sum()
  end

  def p2(input \\ Utils.get_input(2023, 1)) do
  end
end
