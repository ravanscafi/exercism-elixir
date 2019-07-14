defmodule Garden do
  @plants [
    V: :violets,
    C: :clover,
    R: :radishes,
    G: :grass,
  ]

  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry,
  ]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    student_names = Enum.sort(student_names)
    student_list = Enum.reduce(student_names, %{}, &(Map.put(&2, &1, {})))

    String.split(info_string, "\n")
    |> Enum.map(&convert/1)
    |> List.flatten
    |> Enum.reduce(student_list, &(assign(&1, &2, student_names)))
  end

  defp assign({value, index}, acc, student_names) do
    key = Enum.at(student_names, index)
    new = Enum.reduce(value, Map.get(acc, key), &(Tuple.append(&2, &1)))
    Map.put(acc, key, new)
  end

  defp convert(info) do
    info
    |> String.graphemes
    |> Enum.map(&(@plants[String.to_atom(&1)]))
    |> Enum.chunk_every(2)
    |> Enum.with_index
  end
end
