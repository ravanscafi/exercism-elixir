defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, base_b) do
    if valid?(digits, base_a) do
      digits
      |> digits_to_number(base_a)
      |> number_to_digits(base_b)
    end
  end

  defp valid?(digits, base) do
    not Enum.any?(digits, &(&1 < 0 or &1 >= base))
  end

  defp digits_to_number(digits, base) do
    digits
    |> Enum.reduce(
      {0, Enum.count(digits) - 1},
      fn(digit, {acc, power}) -> {acc + digit_to_number(digit, base, power), power - 1} end
    )
    |> elem(0)
  end

  defp digit_to_number(digit, base, expoent) do
    digit * :math.pow(base, expoent)
    |> round()
  end

  defp number_to_digits(num, base), do: number_to_digits_acc(num, base, [])

  defp number_to_digits_acc(0, _, []), do: [0]

  defp number_to_digits_acc(0, _, acc), do: acc

  defp number_to_digits_acc(num, base, acc) do
    number_to_digits_acc(div(num, base), base, [rem(num, base) | acc])
  end
end
