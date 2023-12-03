# defmodule GenMap do
#   def maxMap(str, map) do
#     case str do
#       "" ->

#     end
#   end
# end

# elem(File.read("../inputs/d1smol.txt"), 1)
# |> IO.puts()
file = "../inputs/d2full.txt"

boundMap = %{red: 12, green: 13, blue: 14}

File.read(file)
|> then(fn a -> elem(a, 1) end)
|> String.split("\r\n\r\n")
|> List.first()
|> String.split("\r\n")
|> IO.inspect()
|> Enum.each(fn line -> IO.puts(line) end)
|> Enum.map(fn line ->
  number =
    Regex.run(~r/Game ([0-9]+)/, line)
    |> Enum.at(1)
    |> Integer.parse()
    |> elem(0)

  line = String.replace(line, ~r/Game ([0-9]+): /, "")
  %{number: number, line: line}
  # |> elem(1)
  # |> Integer.parse()
  # |> elem(1)
  # |> IO.puts()
end)
|> Enum.map(fn m ->
  String.split(m[:line], ~r/(; )|(, )/)
  |> List.foldl(
    %{red: 0, blue: 0, green: 0},
    fn pair, mapAcc ->
      Integer.parse(pair)
      |> case do
        {x, " red"} -> Map.replace!(mapAcc, :red, max(x, mapAcc[:red]))
        {x, " blue"} -> Map.replace!(mapAcc, :blue, max(x, mapAcc[:blue]))
        {x, " green"} -> Map.replace!(mapAcc, :green, max(x, mapAcc[:green]))
        _ -> mapAcc
      end
    end
  )
  |> then(fn acc ->
    %{number: m[:number], map: acc}
  end)
end)
|> Enum.filter(fn m ->
  Enum.all?([:red, :green, :blue], fn color -> m[:map][color] <= boundMap[color] end)
end)
|> IO.inspect()
|> Enum.map(fn m -> m[:number] end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()

# |> Enum.map(
#     (fn x -> String.split(x, "")
#     |> Enum.filter(fn x -> Integer.parse(x) != :error end)
#     |> then(fn x -> [List.first(x, "0") <> List.last(x, "0")] end)
#     |> List.to_string()
#     end
#     )
# )
# # |> Enum.each( fn x -> IO.puts(x <> "\n ----") end)
# |> Enum.map(
#   (fn x -> Integer.parse(x) |> elem(0) end)

#   )
# |> Enum.each( fn x -> IO.puts(x) end)
# # |> Enum.each( fn x -> IO.puts(x <> "\n ----") end)
# |> Enum.sum()
# |> IO.puts()

# ["6 red", "1 blue", "3 green", "2 blue", "1 red", "2 green"]
# line = "6 red, 1 blue, 3 green  ; 2 blue, 1 red, 2 green  "

# # foldr mcMapFoldr
# String.split(line, ~r/(; )|(, )/)
# |> List.foldl(
#   %{red: 0, blue: 0, green: 0},
#   fn pair, mapAcc -> Integer.parse(pair)
#     |> case do
#       {x, " red"} -> Map.replace!(mapAcc, :red, max(x, mapAcc[:red]))
#       {x, " blue"} -> Map.replace!(mapAcc, :blue, max(x, mapAcc[:blue])) #<> x
#       {x, " green"} -> Map.replace!(mapAcc, :green, max(x, mapAcc[:green])) #<> x
#       _ -> mapAcc
#     end
#   end
# )
