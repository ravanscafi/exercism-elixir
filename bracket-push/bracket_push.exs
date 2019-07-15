defmodule BracketPush do
  @left [?{, ?[, ?(]
  @right [?}, ?], ?)]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    String.to_charlist(str)
    |> Enum.reduce_while([], &do_check/2)
    |> Enum.empty?()
  end

  defp do_check(bracket, buffer) when bracket in @left do
    {:cont, [bracket | buffer]}
  end

  defp do_check(bracket, [h | t]) when bracket in @right do
    i = Enum.find_index(@right, &(&1 === bracket))

    if h === Enum.at(@left, i) do
      {:cont, t}
    else
      {:halt, [h | t]}
    end
  end

  defp do_check(_, buffer), do: {:cont, buffer}
end
