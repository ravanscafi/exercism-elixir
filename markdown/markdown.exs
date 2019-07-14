defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> wrap_items_with_unordered_list
  end

  defp process("#" <> line) do
    "#" <> line
    |> parse_header_level
    |> enclose_with_header_tag
  end

  defp process("*" <> line) do
    "*" <> line
    |> parse_list_level
  end

  defp process(line) do
    line
    |> String.split
    |> enclose_with_paragraph_tag
  end

  defp parse_header_level(text) do
    [header | rest] = String.split(text, " ", parts: 2)
    {to_string(String.length(header)), rest}
  end

  defp enclose_with_header_tag({level, text}) do
    text
    |> enclose_with_tag("h" <> level)
  end

  defp parse_list_level(text) do
    text
    |> String.trim_leading("* ")
    |> String.split
    |> join_words_with_tags
    |> enclose_with_tag("li")
  end

  defp enclose_with_paragraph_tag(text) do
    text
    |> join_words_with_tags
    |> enclose_with_tag("p")
  end

  defp enclose_with_tag(text, tag) do
    "<#{tag}>#{text}</#{tag}>"
  end

  defp join_words_with_tags(text) do
    text
    |> Enum.map_join(" ", &replace_with_tag/1)
  end

  defp replace_with_tag(words) do
    words
    |> replace_prefix
    |> replace_suffix
  end

  defp replace_prefix(words) do
    words
    |> String.replace(~r/^__/, "<strong>")
    |> String.replace(~r/^_/, "<em>")
  end

  defp replace_suffix(words) do
    words
    |> String.replace(~r/__$/, "</strong>")
    |> String.replace(~r/_/, "</em>")
  end

  defp wrap_items_with_unordered_list(text) do
    text
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
