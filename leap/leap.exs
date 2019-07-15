defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    (evenly(year, 4) and
       not evenly(year, 100)) or
      evenly(year, 400)
  end

  defp evenly(year, num), do: rem(year, num) == 0
end
