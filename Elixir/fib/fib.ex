defmodule Maths do
  def fib(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> fib(n - 1) + fib(n - 2)
    end
  end
end

# Maths.fib(20)
# |> IO.inspect()

if System.argv() |> length() >= 1 do
  System.argv()
  |> Enum.at(0)
  |> Integer.parse()
  |> case do
    :error -> IO.puts("Error in reading command line args")
    {x, _} -> Maths.fib(x) |> IO.inspect()
  end
else
  IO.puts("Failed to read command line args: [#{System.argv()}]")
end
