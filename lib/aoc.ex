defmodule Aoc do
  @callback p1(String.t()) :: any

  @callback p2(String.t()) :: any

  @optional_callbacks p2: 1

  defmacro aoc(year, day, do: body) do
    quote do
      defmodule unquote(module_name(year, day)) do
        @behaviour Aoc

        @year unquote(year)
        @day unquote(day)

        unquote(body)
      end
    end
  end

  def module_name(year, day) do
    Module.concat(String.to_atom("Aoc.Y#{year}"), String.to_atom("D#{day}"))
  end
end
