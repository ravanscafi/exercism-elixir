defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    _keep(list, fun, [])
  end

  defp _keep([head | tail], fun, acc) do
    if fun.(head) do
      [head | _keep(tail, fun, acc)]
    else
      _keep(tail, fun, acc)
    end
  end

  defp _keep([], _, acc), do: acc

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    _keep(list, &(!fun.(&1)), [])
  end
end
