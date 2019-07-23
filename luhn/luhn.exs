defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    valid_format?(number) and valid_value?(number)
  end

  defp valid_format?(number) do
    String.match?(number, ~r/^\s*(\d+\s*){2,}$/)
  end

  defp valid_value?(number) do
    0 ==
      number
      |> String.replace(" ", "")
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(&convert/1)
      |> Enum.sum()
      |> rem(10)
  end

  defp convert({digit, index}) when rem(index, 2) != 0 do
    convert({digit * 2, 0})
  end

  defp convert({digit, _index}) when digit > 9, do: digit - 9

  defp convert({digit, _index}), do: digit
end
