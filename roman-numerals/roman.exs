defmodule Roman do
  @mapping [
    M: 1000,
    CM: 900,
    D:  500,
    CD: 400,
    C:  100,
    XC:  90,
    L:   50,
    XL:  40,
    X:   10,
    IX:   9,
    V:    5,
    IV:   4,
    I:    1,
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    {0, converted} = Enum.reduce(@mapping, {number, ""}, &convert/2)
    converted
  end

  defp convert({_, factor}, {number, acc}) when number - factor < 0 do
    {number, acc}
  end

  defp convert({symbol, factor}, {number, acc}) do
    convert({symbol, factor},{number - factor, acc <> to_string(symbol)})
  end
end
