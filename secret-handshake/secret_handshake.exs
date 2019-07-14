defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    list = if (code &&& 0b1) == 0b1, do: ["wink"], else: []
    list = list ++ if (code &&& 0b10) == 0b10, do: ["double blink"], else: []
    list = list ++ if (code &&& 0b100) == 0b100, do: ["close your eyes"], else: []
    list = list ++ if (code &&& 0b1000) == 0b1000, do: ["jump"], else: []
    if (code &&& 0b10000) == 0b10000, do: Enum.reverse(list), else: list
  end
end
