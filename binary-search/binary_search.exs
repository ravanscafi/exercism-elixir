defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found

  def search(tuple, key) do
    search(tuple, key, 0, tuple_size(tuple) - 1)
  end

  defp search(_tuple, _key, min, max) when min > max, do: :not_found

  defp search(tuple, key, min, max) do
    position = div(min + max, 2)
    subject = elem(tuple, position)

    cond do
      key < subject -> search(tuple, key, min, position - 1)
      key > subject -> search(tuple, key, position + 1, max)
      true -> {:ok, position}
    end
  end
end
