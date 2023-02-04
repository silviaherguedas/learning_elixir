defmodule LearningElixir.RomanNumbersBetter do
  @moduledoc false

  @type roman_acc :: [binary]

  # Cond implementation
  # Even when this implementation has a cyclomatic complexity of 15, it's preferred over the
  # pattern matching option because it is more legible.
  @spec from_integer(pos_integer, roman_acc) :: binary
  def from_integer(integer, acc \\ []) do
    cond do
      integer >= 1000 -> from_integer(integer - 1000, ["M" | acc])
      integer >= 900 -> from_integer(integer - 900, ["CM" | acc])
      integer >= 500 -> from_integer(integer - 500, ["D" | acc])
      integer >= 400 -> from_integer(integer - 400, ["CD" | acc])
      integer >= 100 -> from_integer(integer - 100, ["C" | acc])
      integer >= 90 -> from_integer(integer - 90, ["XC" | acc])
      integer >= 50 -> from_integer(integer - 50, ["L" | acc])
      integer >= 40 -> from_integer(integer - 40, ["XL" | acc])
      integer >= 10 -> from_integer(integer - 10, ["X" | acc])
      integer >= 9 -> from_integer(integer - 9, ["IX" | acc])
      integer >= 5 -> from_integer(integer - 5, ["V" | acc])
      integer >= 4 -> from_integer(integer - 4, ["IV" | acc])
      integer >= 1 -> from_integer(integer - 1, ["I" | acc])
      true -> acc |> Enum.reverse() |> Enum.join()
    end
  end

  @spec to_integer(binary, integer) :: integer
  def to_integer(roman, acc \\ 0)
  def to_integer("M" <> rest, acc), do: to_integer(rest, acc + 1000)
  def to_integer("CM" <> rest, acc), do: to_integer(rest, acc + 900)
  def to_integer("D" <> rest, acc), do: to_integer(rest, acc + 500)
  def to_integer("CD" <> rest, acc), do: to_integer(rest, acc + 400)
  def to_integer("C" <> rest, acc), do: to_integer(rest, acc + 100)
  def to_integer("XC" <> rest, acc), do: to_integer(rest, acc + 90)
  def to_integer("L" <> rest, acc), do: to_integer(rest, acc + 50)
  def to_integer("XL" <> rest, acc), do: to_integer(rest, acc + 40)
  def to_integer("X" <> rest, acc), do: to_integer(rest, acc + 10)
  def to_integer("IX" <> rest, acc), do: to_integer(rest, acc + 9)
  def to_integer("V" <> rest, acc), do: to_integer(rest, acc + 5)
  def to_integer("IV" <> rest, acc), do: to_integer(rest, acc + 4)
  def to_integer("I" <> rest, acc), do: to_integer(rest, acc + 1)
  def to_integer("", acc), do: acc
end
