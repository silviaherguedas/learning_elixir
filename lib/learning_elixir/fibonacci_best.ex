defmodule LearningElixir.FibonacciBest do
  @moduledoc false

  require Integer

  @spec fibonacci(pos_integer, [pos_integer]) :: [pos_integer]
  def fibonacci(limit, serie \\ [2, 1, 1])
  def fibonacci(0, _), do: []
  def fibonacci(1, _), do: [1, 1]
  def fibonacci(2, _), do: [2, 1, 1]

  def fibonacci(limit, [head1, head2 | _tail] = serie) when head1 + head2 <= limit,
    do: fibonacci(limit, [head1 + head2 | serie])

  def fibonacci(_, serie), do: serie

  @spec fibonacci_sum(pos_integer) :: pos_integer
  def fibonacci_sum(limit) do
    limit
    |> fibonacci()
    |> Stream.filter(&Integer.is_even/1)
    |> Enum.sum()
  end
end
