defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    clean =
      sentence
      |> String.replace(~r/[^[:alpha:]]+/u, "")
      |> String.downcase()
      |> String.graphemes()

    clean === Enum.uniq(clean)
  end
end
