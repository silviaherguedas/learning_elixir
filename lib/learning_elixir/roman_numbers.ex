defmodule LearningElixir.RomanNumbers do
  @moduledoc false

  @type roman_acc :: [binary]

  @spec from_integer(pos_integer, roman_acc) :: binary
  def from_integer(integer, acc \\ [])

  def from_integer(integer, acc) when integer >= 1000,
    do: from_integer(integer - 1000, ["M" | acc])

  def from_integer(integer, acc) when integer >= 900,
    do: from_integer(integer - 900, ["CM" | acc])

  def from_integer(integer, acc) when integer >= 500, do: from_integer(integer - 500, ["D" | acc])

  def from_integer(integer, acc) when integer >= 400,
    do: from_integer(integer - 400, ["CD" | acc])

  def from_integer(integer, acc) when integer >= 100, do: from_integer(integer - 100, ["C" | acc])
  def from_integer(integer, acc) when integer >= 90, do: from_integer(integer - 90, ["XC" | acc])
  def from_integer(integer, acc) when integer >= 50, do: from_integer(integer - 50, ["L" | acc])
  def from_integer(integer, acc) when integer >= 40, do: from_integer(integer - 40, ["XL" | acc])
  def from_integer(integer, acc) when integer >= 10, do: from_integer(integer - 10, ["X" | acc])
  def from_integer(integer, acc) when integer >= 9, do: from_integer(integer - 9, ["IX" | acc])
  def from_integer(integer, acc) when integer >= 5, do: from_integer(integer - 5, ["V" | acc])
  def from_integer(integer, acc) when integer >= 4, do: from_integer(integer - 4, ["IV" | acc])
  def from_integer(integer, acc) when integer >= 1, do: from_integer(integer - 1, ["I" | acc])
  def from_integer(0, acc), do: acc |> Enum.reverse() |> Enum.join()
end
