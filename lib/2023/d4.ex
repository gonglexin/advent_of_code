import Aoc

aoc 2023, 4 do
  alias Aoc.Utils

  def p1(input \\ Utils.get_input(@year, @day)) do
    input
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(&extract_numbers/1)
    |> Enum.map(&count_winning_numbers/1)
    |> Enum.map(&calc_points/1)
    |> Enum.sum()
  end

  defp extract_numbers(line) do
    regex = ~r/Card .*: (?<a>.*) \| (?<b>.*)$/
    %{"a" => a, "b" => b} = Regex.named_captures(regex, line)

    [a, b]
    |> Enum.map(fn numbers ->
      Regex.scan(~r/\d+/, numbers)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
    end)
  end

  defp count_winning_numbers([a, b]) do
    Enum.count(a, fn d -> d in b end)
  end

  defp calc_points(0), do: 0
  defp calc_points(1), do: 1
  defp calc_points(n), do: Integer.pow(2, n - 1)
end
