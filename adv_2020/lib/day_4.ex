defmodule DayFour do
  def solve(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&construct_passport/1)
    |> Enum.map(&validate_passport/1)
    |> Enum.count(& &1)
  end

  @docp """
  Constructs a keyword list from string of passport data.
  """
  defp construct_passport(string) do
    string
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(fn
      x ->
        [key, val] = String.split(x, ":", trim: true)
        {String.to_atom(key), val}
    end)
  end

  defp validate_passport(passport) do
    with {:ok, _} <- Keyword.fetch(passport, :byr),
         {:ok, _} <- Keyword.fetch(passport, :iyr),
         {:ok, _} <- Keyword.fetch(passport, :eyr),
         {:ok, _} <- Keyword.fetch(passport, :hgt),
         {:ok, _} <- Keyword.fetch(passport, :hcl),
         {:ok, _} <- Keyword.fetch(passport, :ecl),
         {:ok, _} <- Keyword.fetch(passport, :pid) do
      true
    else
      _ -> false
    end
  end
end
