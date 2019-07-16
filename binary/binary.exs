defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    list = String.graphemes(string)

    if is_valid?(list) do
      list
      |> Enum.map(&String.to_integer/1)
      |> digits_to_number()
    else
      0
    end
  end

  defp is_valid?(list) do
    list
    |> Enum.all?(&(&1 in ["0", "1"]))
  end

  defp digits_to_number(digits) do
    digits
    |> Enum.reduce(
      {0, Enum.count(digits) - 1},
      fn digit, {acc, power} -> {acc + digit_to_number(digit, power), power - 1} end
    )
    |> elem(0)
  end

  defp digit_to_number(digit, expoent) do
    (digit * :math.pow(2, expoent))
    |> round()
  end
end
