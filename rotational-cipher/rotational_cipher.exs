defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<char>> <> text, shift) do
    <<shift(char, shift)>> <> rotate(text, shift)
  end

  def rotate(_, _), do: ""

  defp shift(char, shift) when char in ?a..?z do
    ?a + rem(char - ?a + shift, 26)
  end

  defp shift(char, shift) when char in ?A..?Z do
    ?A + rem(char - ?A + shift, 26)
  end

  defp shift(char, _), do: char
end
