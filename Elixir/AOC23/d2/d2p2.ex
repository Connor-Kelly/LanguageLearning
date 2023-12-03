file = "../inputs/d2full.txt"
# file = "../inputs/d2smol.txt"

File.read(file)
|> then(fn a -> elem(a, 1) end)
|> String.split("\r\n\r\n")
|> List.first()
|> String.split("\r\n")
|> IO.inspect()
|> Enum.map(fn line ->
  number =
    Regex.run(~r/Game ([0-9]+)/, line)
    |> Enum.at(1)
    |> Integer.parse()
    |> elem(0)

  line = String.replace(line, ~r/Game ([0-9]+): /, "")
  %{number: number, line: line}
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
|> IO.inspect()
|> Enum.map(fn m -> m[:map][:red] * m[:map][:green] * m[:map][:blue] end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()

