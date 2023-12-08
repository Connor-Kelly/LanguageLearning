defmodule User do
  defstruct [:name, :age]
end

defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: User do
  def size(_user), do: 2
end
