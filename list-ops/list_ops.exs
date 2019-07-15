defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([], acc) do
    acc
  end

  defp do_count(l, acc) do
    [_ | t] = l
    do_count(t, acc + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], acc) do
    acc
  end

  defp do_reverse(l, acc) do
    [h | t] = l
    do_reverse(t, [h | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  defp do_map([], _, acc) do
    acc
  end

  defp do_map(l, f, acc) do
    [h | t] = l
    [f.(h) | do_map(t, f, acc)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  defp do_filter([], _, acc) do
    acc
  end

  defp do_filter(l, f, acc) do
    [h | t] = l
    filtered_t = do_filter(t, f, acc)

    if f.(h) do
      [h | filtered_t]
    else
      filtered_t
    end
  end

  def reduce([], acc, _) do
    acc
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    [h | t] = l
    reduce(t, f.(h, acc), f)
  end

  def append([], b) do
    b
  end

  @spec append(list, list) :: list
  def append(a, b) do
    [h | t] = a
    [h | append(t, b)]
  end

  def concat([]) do
    []
  end

  @spec concat([[any]]) :: [any]
  def concat(l) do
    [h | t] = l
    ListOps.append(h, concat(t))
  end
end
