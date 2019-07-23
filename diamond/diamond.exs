defmodule Diamond do
  @new_line "\n"

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(char), do: build_shape(?A, char)

  defp build_shape(?A, ?A), do: "A" <> @new_line

  # middle
  defp build_shape(char, char) do
    middle = dup(2 * (char - ?A) - 1)

    <<char>> <> middle <> <<char>> <> @new_line
  end

  # corners
  defp build_shape(?A, max) do
    side = dup(max - ?A)
    wrap = side <> "A" <> side <> @new_line

    wrap <> build_shape(?B, max) <> wrap
  end

  # others
  defp build_shape(char, max) do
    side = dup(max - char)
    middle = dup(2 * (char - ?A) - 1)
    wrap = side <> <<char>> <> middle <> <<char>> <> side <> @new_line

    wrap <> build_shape(char + 1, max) <> wrap
  end

  defp dup(times), do: String.duplicate(" ", times)
end
