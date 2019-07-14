defmodule ProteinTranslation do
  @stop_protein "STOP"

  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => @stop_protein,
    "UAG" => @stop_protein,
    "UGA" => @stop_protein,
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna), do: do_decode(rna, [])

  defp do_decode("", acc), do: {:ok, Enum.reverse(acc)}

  defp do_decode(<<codon::binary-3>> <> tail, acc) do
    case of_codon(codon) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, @stop_protein} -> do_decode("", acc)
      {:ok, protein} -> do_decode(tail, [protein | acc])
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein_name(@proteins[codon])
  end

  defp protein_name(nil), do: {:error, "invalid codon"}
  defp protein_name(name), do: {:ok, name}
end
