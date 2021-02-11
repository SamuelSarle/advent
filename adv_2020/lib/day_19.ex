defmodule DayNineteen do
  def solve(input) do
    [rules, data] = input |> String.split("\n\n", trim: true)

    valid_re =
      format_rules(rules)
      |> create_regex()
      |> Regex.compile!()

    data = format_data(data)

    data
    |> Enum.filter(fn x -> x |> String.match?(valid_re) end)
    |> Enum.count()
  end

  def create_regex(rules) do
    zero = Map.fetch!(rules, 0)

    if zero |> String.match?(~r/\d/) do
      replacer = fn
        x -> "(" <> Map.fetch!(rules, String.to_integer(x)) <> ")"
      end

      new_zero =
        zero
        |> String.replace(~r/\d+/, replacer)

      Map.put(rules, 0, new_zero)
      |> create_regex()
    else
      zero
      |> String.replace(" ", "")
      |> String.replace(~r/\((a|b)\)/, "\\1")
      |> String.replace_prefix("", "^")
      |> String.replace_suffix("", "$")
    end
  end

  def format_rules(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      x ->
        [key, val] =
          x
          |> String.replace("\"", "")
          |> String.split(": ", trim: true)

        {String.to_integer(key), val}
    end)
    |> Map.new()
  end

  def format_data(input) do
    input
    |> String.split("\n", trim: true)
  end
end
