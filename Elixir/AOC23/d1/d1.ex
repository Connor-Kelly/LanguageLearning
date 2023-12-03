# "../inputs/d1full.txt"

defmodule Day1 do
  def run(filename) do
    File.read(filename)
    |> then(fn a -> elem(a, 1) end)
    |> String.split("\r\n\r\n")
    |> List.first()
    |> String.split("\r\n")
    |> Enum.map(fn x ->
      String.split(x, "")
      |> Enum.filter(fn x -> Integer.parse(x) != :error end)
      # |> IO.inspect()
      |> then(fn x -> [List.first(x, "0") <> List.last(x, "0")] end)
      |> List.to_string()
    end)
    |> IO.inspect()
    # |> Enum.each( fn x -> IO.puts(x <> "\n ----") end)
    |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day1.run("../inputs/d1full.txt")
