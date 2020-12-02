defmodule DayTwo.PartTwo do
  @doc """
  Gets the requirements for the password and checks that they're met.
  """
  def solve(list) do
    list
    |> Stream.map(&DayTwo.interpret_params/1)
    |> Stream.map(&check_pass/1)
    |> Enum.count(& &1)
  end

  @doc """
  Checks that character matches the character in pass at place (first) xor (second).
  """
  defp check_pass({first, second, char, pass}) when is_integer(first) and is_integer(second) do
    # change from 0-indexed to 1-indexed
    _check_pass({first - 1, second - 1, char, pass})
  end

  defp _check_pass({first, second, char, pass}) do
    count =
      [first, second]
      |> Enum.map(&(String.at(pass, &1) == char))
      |> Enum.count(& &1)

    case count do
      1 -> true
      _ -> false
    end
  end
end
