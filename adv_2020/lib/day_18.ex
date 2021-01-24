defmodule DayEighteen do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&reduce/1)
    |> Enum.sum()
  end

  def reduce(input) do
    if Regex.match?(~r/^\d*$/, input) do
      input |> String.to_integer()
    else
      input
      |> String.replace(~r/(?:^|\()([\d\s\+\*]+)(?:$|\))/, &apply_math/1, global: false)
      |> reduce()
    end
  end

  def apply_math(input) do
    if Regex.match?(~r/^\(?\d+\)?$/, input) do
      input |> String.replace(~r/[^\d]/, "")
    else
      input
      |> String.replace(
        ~r/(\d+) ([+*]) (\d+)/,
        fn x ->
          [a, op, b] =
            x
            |> String.split()
            |> Enum.map(fn
              "*" -> "*"
              "+" -> "+"
              n -> n |> String.to_integer()
            end)

          eval(a, op, b) |> to_string()
        end,
        global: false
      )
      |> apply_math()
    end
  end

  def eval(a, "+", b), do: a + b
  def eval(a, "*", b), do: a * b
end
