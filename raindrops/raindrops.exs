defmodule Raindrops do
  @map %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    converted =
      Enum.reduce(
        @map,
        "",
        fn {by, text}, acc ->
          remtext(number, by, acc, text)
        end
      )

    print(number, converted)
  end

  defp remtext(n, by, acc, text) when rem(n, by) === 0 do
    acc <> text
  end

  defp remtext(_, _, acc, _), do: acc

  defp print(number, ""), do: to_string(number)

  defp print(_, converted), do: converted
end
