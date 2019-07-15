defmodule PigLatin do
  @vowels [?a, ?e, ?i, ?o, ?u]
  @group_of_two ["ch", "qu", "th"]
  @group_of_three ["squ", "thr", "sch"]
  @like_vowels [?x, ?y]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&(do_translate(&1) <> "ay"))
    |> Enum.join(" ")
  end

  defp do_translate(<<first>> <> rest) when first in @vowels do
    <<first>> <> rest
  end

  defp do_translate(<<first>> <> <<second>> <> rest)
       when first in @like_vowels and second not in @vowels do
    <<first>> <> <<second>> <> rest
  end

  defp do_translate(<<two::binary-2>> <> rest) when two in @group_of_two do
    do_translate(rest <> two)
  end

  defp do_translate(<<three::binary-3>> <> rest) when three in @group_of_three do
    do_translate(rest <> three)
  end

  defp do_translate(<<first>> <> rest) do
    do_translate(rest <> <<first>>)
  end
end
