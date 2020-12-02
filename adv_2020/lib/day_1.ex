defmodule DayOne do
  @target 2020

  def solve([]), do: :nil
  def solve(list) do
    with {l, r} <- _check_list_elems(list) do
      l * r
    else
      _ -> :nil
    end
  end

  def _check_list_elems([]), do: :nil
  def _check_list_elems([head | tail]) do
    case _find_pair(head, tail) do
      {_, _} = pair -> pair
      _ -> _check_list_elems(tail)
    end
  end

  def _find_pair(_elem, []), do: :nil
  def _find_pair(elem, [head | tail]) do
    case elem + head do
      @target -> {elem, head}
      _ -> _find_pair(elem, tail)
    end
  end
end
