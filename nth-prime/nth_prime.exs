defmodule Prime do
  @max_iter 10_000_000

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    next_prime(1, count)
  end

  defp next_prime(last, 0), do: last

  defp next_prime(last, count) do
    new =
      Enum.reduce_while(
        (last + 1)..@max_iter,
        count,
        &if(prime?(&1), do: {:halt, &1}, else: {:cont, &2})
      )

    next_prime(new, count - 1)
  end

  defp prime?(2), do: true

  defp prime?(n) do
    Enum.all?(2..(trunc(:math.sqrt(n)) + 1), &(rem(n, &1) !== 0))
  end
end

# 1 + 2*(n-1)
