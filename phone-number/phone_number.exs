defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    number = clean(raw)
    if valid?(number), do: number, else: "0000000000"
  end

  @spec clean(String.t()) :: String.t()
  defp clean(raw) do
    no_specials = Regex.replace(~r/[\(\)\s\.-]+/i, raw, "")
    Regex.replace(~r/1(\d{10})/, no_specials, "\\1")
  end

  @spec valid?(String.t()) :: boolean
  defp valid?(number) do
    String.match?(number, ~r/^\d{10}$/)
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    number(raw)
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    number(raw)
    |> String.replace(~r/(^\d{3})(\d{3})(\d{4})$/, "(\\1) \\2-\\3")
  end
end
