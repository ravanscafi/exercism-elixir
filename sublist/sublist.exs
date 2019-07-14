defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      is_sublist(a, b) -> :sublist
      is_sublist(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp is_sublist(a, b) do
    ca = Enum.count(a)

    cond do
      ca > Enum.count(b) -> false
      Enum.take(b, ca) === a -> true
      true -> is_sublist(a, tl(b))
    end
  end
end
