defmodule LearningElixir.PrimeNumbersTransform do
  @moduledoc false

  @spec generator :: Enumerable.t()
  def generator do
    2
    |> Stream.iterate(&(&1 + 1))
    |> Stream.transform([], fn n, prime_numbers ->
        if is_prime?(prime_numbers, n) do
          {[n], [n | prime_numbers]}
        else
          {[], prime_numbers}
        end
    end)
  end

  @spec is_prime?([pos_integer], pos_integer) :: boolean
  defp is_prime?([], _), do: true

  defp is_prime?([prime | rest], n) do
    if rem(n, prime) == 0 do
      false
    else
      is_prime?(rest, n)
    end
  end
end
