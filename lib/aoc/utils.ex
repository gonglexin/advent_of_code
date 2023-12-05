defmodule Aoc.Utils do
  @base_url "https://adventofcode.com"

  def get_input(year, day) do
    if in_cache?(year, day), do: from_cache!(year, day), else: download!(year, day)
  end

  defp cache_path(day, year), do: Path.join(cache_dir(), "/#{year}/#{day}.aocinput")
  defp in_cache?(day, year), do: File.exists?(cache_path(day, year))

  defp store_in_cache!(day, year, input) do
    path = cache_path(day, year)
    :ok = path |> Path.dirname() |> File.mkdir_p()
    :ok = File.write(path, input)
  end

  defp from_cache!(day, year), do: File.read!(cache_path(day, year))

  defp download!(year, day) do
    url = "#{@base_url}/#{year}/day/#{day}/input"

    input =
      Req.get!(url, headers: %{cookie: "session=#{System.get_env("AOC_SESSION_COOKIE")}"}).body

    if String.starts_with?(input, "Please don't repeatedly"), do: raise("WRONG INPUT")

    store_in_cache!(day, year, input)

    input
  end

  defp cache_dir do
    Path.join([System.get_env("XDG_CACHE_HOME", "~/.cache"), "/advent_of_code_inputs"])
    |> Path.expand()
  end
end
