defmodule DayFour do
  def solve(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Stream.map(&construct_passport/1)
    |> Stream.map(&validate_passport/1)
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

  # Is there a more idiomatic way of doing this in elixir?
  defp validate_passport(passport) do
    with {:ok, byr} <- Keyword.fetch(passport, :byr),
         :ok <- validate_byr(String.to_integer(byr)),
         {:ok, iyr} <- Keyword.fetch(passport, :iyr),
         :ok <- validate_iyr(String.to_integer(iyr)),
         {:ok, eyr} <- Keyword.fetch(passport, :eyr),
         :ok <- validate_eyr(String.to_integer(eyr)),
         {:ok, hgt} <- Keyword.fetch(passport, :hgt),
         :ok <- validate_hgt(hgt),
         {:ok, hcl} <- Keyword.fetch(passport, :hcl),
         :ok <- validate_hcl(hcl),
         {:ok, ecl} <- Keyword.fetch(passport, :ecl),
         :ok <- validate_ecl(ecl),
         {:ok, pid} <- Keyword.fetch(passport, :pid),
         :ok <- validate_pid(pid) do
      true
    else
      _ -> false
    end
  end

  defp validate_byr(byr) when is_integer(byr) and byr >= 1920 and byr <= 2002, do: :ok
  defp validate_byr(_), do: :error

  defp validate_iyr(iyr) when is_integer(iyr) and iyr >= 2010 and iyr <= 2020, do: :ok
  defp validate_iyr(_), do: :error

  defp validate_eyr(eyr) when is_integer(eyr) and eyr >= 2020 and eyr <= 2030, do: :ok
  defp validate_eyr(_), do: :error

  defp validate_hgt(hgt) do
    # greedy, leaves the rest of the string as the unit
    {h, units} = Integer.parse(hgt)

    cond do
      units == "cm" and h >= 150 and h <= 193 -> :ok
      units == "in" and h >= 59 and h <= 76 -> :ok
      true -> :error
    end
  end

  defp validate_hcl(hcl) do
    case String.match?(hcl, ~r/^#[a-fA-F0-9]{6}$/) do
      true -> :ok
      _ -> :error
    end
  end

  defp validate_ecl(ecl) when ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], do: :ok
  defp validate_ecl(_), do: :error

  defp validate_pid(pid) do
    case String.match?(pid, ~r/^[0-9]{9}$/) do
      true -> :ok
      _ -> :error
    end
  end
end
