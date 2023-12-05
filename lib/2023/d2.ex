import Aoc

aoc 2023, 2 do
  alias Aoc.Utils

  @limit %{
    red: 12,
    green: 13,
    blue: 14
  }

  def p1(input \\ Utils.get_input(@year, @day)) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      pattern = ~r/Game (?<id>\d+): (?<game_data>.*)/
      Regex.named_captures(pattern, s)
    end)
    |> Enum.reject(fn %{"game_data" => game_data} ->
      game_data
      |> String.split("; ")
      |> Enum.flat_map(&String.split(&1, ", "))
      |> Enum.any?(fn s ->
        %{"number" => number, "color" => color} =
          Regex.named_captures(~r/(?<number>\d+) (?<color>.*)/, s)

        String.to_integer(number) > Map.get(@limit, String.to_atom(color))
      end)
    end)
    |> Enum.map(&String.to_integer(&1["id"]))
    |> Enum.sum()
  end

  def p2(input \\ Utils.get_input(@year, @day)) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      pattern = ~r/Game (?<id>\d+): (?<game_data>.*)/
      %{"game_data" => game_data} = Regex.named_captures(pattern, s)

      game_data
      |> String.split("; ")
      |> Enum.flat_map(&String.split(&1, ", "))
      |> Enum.map(fn s ->
        %{"number" => number, "color" => color} =
          Regex.named_captures(~r/(?<number>\d+) (?<color>.*)/, s)

        {String.to_atom(color), String.to_integer(number)}
      end)
      |> Enum.group_by(fn {color, _number} -> color end, fn {_color, number} -> number end)
      |> Enum.map(fn {_k, v} ->
        Enum.max(v)
      end)
    end)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end
end
