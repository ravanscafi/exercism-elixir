defmodule Words do
  defp process_word(word, map) do
    Map.update(map, String.downcase(word), 1, &(&1 + 1))
  end

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.split(sentence, ~r{(\s|[^\w-]|_)+}u, trim: true)
    |> Enum.reduce(%{}, &process_word/2)
  end
end
