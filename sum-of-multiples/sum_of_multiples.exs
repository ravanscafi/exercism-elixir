defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    0..(limit - 1)
    |> Enum.reduce(0, fn number, acc ->
      if(multiple?(number, factors), do: acc + number, else: acc)
    end)
  end

  defp multiple?(number, list) do
    Enum.any?(list, &(rem(number, &1) === 0))
  end
end
