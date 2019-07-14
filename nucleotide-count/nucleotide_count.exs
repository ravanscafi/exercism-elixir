defmodule Nucleotide do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(_, nucleotide) when nucleotide not in @nucleotides, do: raise ArgumentError

  def count(strand, nucleotide) do
    do_count(strand, nucleotide, 0)
  end

  defp do_count('', _, acc), do: acc

  defp do_count([h | _], _, _) when h not in @nucleotides , do: raise ArgumentError

  defp do_count([nucleotide | t], nucleotide, acc) do
    do_count(t, nucleotide, acc + 1)
  end

  defp do_count([_ | t], nucleotide, acc) do
    do_count(t, nucleotide, acc)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce(
      @nucleotides,
      %{},
      fn(n, acc) -> Map.put(acc, n, count(strand, n)) end
    )
  end
end
