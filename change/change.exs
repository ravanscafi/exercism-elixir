defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    coins
    |> Enum.reverse()
    |> take_change(target, [], {:error, "cannot change"})
  end

  defp take_change(_, _, current, {:ok, best}) when length(current) >= length(best) do
    {:ok, best}
  end

  defp take_change([], _, _, best), do: best

  defp take_change(_, 0, current, _), do: {:ok, current}

  defp take_change([coin | list], target, current, best) when coin > target do
    take_change(list, target, current, best)
  end

  defp take_change([coin | list], target, current, best) do
    bigger = take_change([coin | list], target - coin, [coin | current], best)

    take_change(list, target, current, bigger)
  end
end
