defmodule LearningElixir.PrimeNumbersUnfold do
  @moduledoc false

  @spec generator :: Enumerable.t()
  def generator do
    Stream.unfold({2, []}, &next_prime/1)
  end

  @spec next_prime({pos_integer, [pos_integer]}) :: {pos_integer, {pos_integer, [pos_integer]}}
  defp next_prime({n, primes}) do
    if prime?(primes, n) do
      {n, {n + 1, [n | primes]}}
    else
      next_prime({n + 1, primes})
    end
  end

  @spec prime?([pos_integer], pos_integer) :: boolean
  defp prime?([], _), do: true

  defp prime?([prime | rest], n) do
    if rem(n, prime) == 0 do
      false
    else
      prime?(rest, n)
    end
  end
end
