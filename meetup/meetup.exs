defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @weekdays %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @multiplier %{
    :first => 0,
    :second => 1,
    :third => 2,
    :fourth => 3,
    :teenth => 0
  }

  @type weekday ::
          :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, :last) do
    ldom = :calendar.last_day_of_the_month(year, month)
    lwdom = :calendar.day_of_the_week({year, month, ldom})
    day = rewind(ldom, lwdom, @weekdays[weekday])
    {year, month, day}
  end

  def meetup(year, month, weekday, schedule) do
    initial = initial_day(schedule)
    fwdom = :calendar.day_of_the_week({year, month, initial})
    day = skip(fwdom, @weekdays[weekday], @multiplier[schedule])
    {year, month, initial + day}
  end

  defp initial_day(:teenth), do: 13
  defp initial_day(_), do: 1

  defp rewind(ldom, lwdom, weekday) do
    diff = if weekday > lwdom, do: 7, else: 0
    ldom - (lwdom - weekday + diff)
  end

  defp skip(fwdom, weekday, add) do
    diff = if weekday < fwdom, do: 7, else: 0
    weekday - fwdom + diff + 7 * add
  end
end
