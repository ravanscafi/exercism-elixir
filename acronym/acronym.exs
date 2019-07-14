defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r{\B[a-z]+|\W}, trim: true)
    |> Enum.reduce("", &(&2 <> String.upcase(&1)))
  end
end
