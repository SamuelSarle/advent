defmodule DaySix do
  def solve(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Stream.map(&unique_answers/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  def common_answers(input) do
    input =
      input
      |> String.split("\n\n", trim: true)

    answers =
      input
      |> Enum.map(&unique_answers/1)

    groups =
      input
      |> Enum.map(&String.split(&1, "\n", trim: true))

    # zip unique answers among the group and the individual answers of the group together
    Enum.zip(answers, groups)
    |> Stream.map(fn
      # iterate over all unique answers and count the amount that are common in the group
      {grp_ans, grp} -> grp_ans |> Enum.count(&everyone_in_group_has_answer?(&1, grp))
    end)
    |> Enum.sum()
  end

  defp everyone_in_group_has_answer?(answer, group) when is_list(group) do
    group
    |> Enum.all?(&String.contains?(&1, answer))
  end

  defp unique_answers(group) do
    Regex.scan(~r/[a-z]/i, group)
    |> Enum.concat()
    |> Enum.uniq()
  end
end
