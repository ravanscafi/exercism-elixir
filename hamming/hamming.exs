defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer}
  @spec hamming_distance([char], [char]) :: {:error, String.t}
  def hamming_distance(strand1, strand2) do
    calculate(strand1, strand2, 0)
  end

  defp calculate(s, s, acc), do: {:ok, acc}

  defp calculate(s1, s2, _) when s1 == [] or s2 == [] do
    {:error, "Lists must be the same length"}
  end

  defp calculate([h | t1], [h | t2], acc), do: calculate(t1, t2, acc)

  defp calculate([_ | t1], [_ | t2], acc), do: calculate(t1, t2, acc + 1)
end
