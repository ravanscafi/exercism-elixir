defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, &compare(base, &1))
  end

  defp compare(base, candidate) do
    b = String.downcase(base)
    c = String.downcase(candidate)

    b !== c and prepare(b) === prepare(c)
  end

  defp prepare(string) do
    String.codepoints(string)
    |> Enum.sort
  end
end
