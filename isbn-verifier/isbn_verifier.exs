defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    clean_isbn = String.replace(isbn, "-", "")

    valid_format?(clean_isbn) and valid_value?(clean_isbn)
  end

  defp valid_format?(isbn), do: String.match?(isbn, ~r/^\d{9}[\dX]$/)

  defp valid_value?(isbn) do
    0 ==
      isbn
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(0, &sum/2)
      |> rem(11)
  end

  defp sum({"X", index}, acc), do: sum({"10", index}, acc)

  defp sum({digit, index}, acc) do
    String.to_integer(digit) * (10 - index) + acc
  end
end
