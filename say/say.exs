defmodule Say do
  @numbers %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @trillion 1_000_000_000_000
  @billion 1_000_000_000
  @million 1_000_000
  @thousand 1_000
  @hundred 100

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number >= @trillion do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}

  def in_english(number), do: {:ok, fetch(number)}

  defp fetch(number) when number >= @billion do
    fetch_decimal(number, "billion", @billion)
  end

  defp fetch(number) when number >= @million do
    fetch_decimal(number, "million", @million)
  end

  defp fetch(number) when number >= @thousand do
    fetch_decimal(number, "thousand", @thousand)
  end

  defp fetch(number) when number >= @hundred do
    fetch_decimal(number, "hundred", @hundred)
  end

  defp fetch(number) when number > 20 and rem(number, 10) != 0 do
    rem = rem(number, 10)

    fetch(number - rem)
    |> join(fetch(rem), "-")
  end

  defp fetch(0), do: ""

  defp fetch(number) do
    @numbers[number]
  end

  defp fetch_decimal(number, word, decimal) do
    fetch(div(number, decimal))
    |> join(word)
    |> join(fetch(rem(number, decimal)))
  end

  defp join(word1, ""), do: word1

  defp join(word1, word2, glue \\ " "), do: "#{word1}#{glue}#{word2}"
end
