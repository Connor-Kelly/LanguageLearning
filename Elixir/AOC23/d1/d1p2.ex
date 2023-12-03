

defmodule WordToInt do
#   def parseString(str) do
#     case str do
#       "" <> x <> "one" <> y -> x <> "1" <> y
#       _ -> str
#     end
#     # parseString(tail, head + accumulator)
  def replaceAllNumbers(tail, acc) do
    case tail do
      # "zero" <> str -> replaceAllNumbers(str, acc <> "0")
      "one" <> str -> replaceAllNumbers("e" <> str, acc <> "1")
      "two" <> str -> replaceAllNumbers("o" <> str, acc <> "2")
      "three" <> str -> replaceAllNumbers("e" <> str, acc <> "3")
      "four" <> str -> replaceAllNumbers(str, acc <> "4")
      "five" <> str -> replaceAllNumbers("e" <> str, acc <> "5")
      "six" <> str -> replaceAllNumbers(str, acc <> "6")
      "seven" <> str -> replaceAllNumbers("n" <> str, acc <> "7")
      "eight" <> str -> replaceAllNumbers("t" <> str, acc <> "8")
      "nine" <> str -> replaceAllNumbers("e" <> str, acc <> "9")
      "" -> acc
      str -> replaceAllNumbers(String.slice(str, 1..-1//1), acc <> String.first(str))

    end
    # Regex.replace(~r/zero/, str, "0")
    # |> then(fn s -> Regex.replace(~r/one/, s, "1") end)
    # |> then(fn s -> Regex.replace(~r/two/, s, "2") end)
    # |> then(fn s -> Regex.replace(~r/three/, s, "3") end)
    # |> then(fn s -> Regex.replace(~r/four/, s, "4") end)
    # |> then(fn s -> Regex.replace(~r/five/, s, "5") end)
    # |> then(fn s -> Regex.replace(~r/six/, s, "6") end)
    # |> then(fn s -> Regex.replace(~r/seven/, s, "7") end)
    # |> then(fn s -> Regex.replace(~r/eight/, s, "8") end)
    # |> then(fn s -> Regex.replace(~r/nine/, s, "9") end)
  end
end

#   # def parseString([]) do
#   #   accumulator
#   # end
# end

# elem(File.read("../inputs/d1smol.txt"), 1)
# |> IO.puts()

File.read("../inputs/d1full.txt")
|> then(fn a -> elem(a, 1) end)
|> String.split("\r\n\r\n")
|> List.first()
|> String.split("\r\n")
|> Enum.map(fn line -> WordToInt.replaceAllNumbers(line, "") end)
# |> Enum.each( fn x -> IO.puts(x) end)

|> Enum.map(
    (fn x -> String.split(x, "")
    |> Enum.filter(fn x -> Integer.parse(x) != :error end)
    |> then(fn x -> [List.first(x, "0") <> List.last(x, "0")] end)
    |> List.to_string()
    end
    )
)
# |> Enum.each( fn x -> IO.puts(x <> "\n ----") end)
|> Enum.map(
  (fn x -> Integer.parse(x) |> elem(0) end)
  )
# |> Enum.each( fn x -> IO.puts(x) end)
# # |> Enum.each( fn x -> IO.puts(x <> "\n ----") end)
|> Enum.sum()
|> IO.puts()
