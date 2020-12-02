defmodule DayTwo do
  @doc """
  Gets the requirements for the password and checks that they're met.
  """
  def solve(list) do
    list
    |> Stream.map(&interpret_params/1)
    |> Enum.map(&check_pass/1)
    |> Enum.count(fn x -> x == true end)
  end

  defp check_pass({min, _, _, ""}) when min > 0, do: false

  defp check_pass({min, max, char, pass}) do
    count = Regex.scan(~r/#{char}/, pass) |> Enum.count()

    cond do
      count < min -> false
      count > max -> false
      true -> true
    end
  end

  def interpret_params(string) do
    with [amount, char, pass] <- String.split(string, " ", trim: true),
         [min, max] <- String.split(amount, "-") |> Enum.map(&String.to_integer/1) do
      {min, max, String.at(char, 0), pass}
    else
      _ -> :error
    end
  end
end
