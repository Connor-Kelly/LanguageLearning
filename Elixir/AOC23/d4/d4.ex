filepath = "../inputs/d4smol.txt"
# filepath = "../inputs/d4full.txt"

File.read(filepath)
|> elem(1)
|> String.split("\r\n")
|> IO.inspect()
|> Enum.map(fn line ->
  l = line |> String.split(~r/:\s+/) |> Enum.at(1) |> String.split(" | ")
  winners = l |> List.first() |> String.split(~r/\s+/)
  # |> IO.inspect()
  have = l |> List.last() |> String.split(~r/\s+/)
  # |> IO.inspect()

  have
  |> Enum.map(fn h ->
    winners
    |> Enum.filter(fn w ->
      w == h
    end)
    |> length()
  end)
  |> Enum.sum()
  |> then(fn s ->
    if s > 0 do
      Integer.pow(2, s - 1)
    else
      0
    end
  end)
end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
# |> Enum.reverse()
# |> then(fn list ->
#   for x <- 0..length(list) do
#     Enum.at(list, x) |> IO.inspect()
#   end
# end)
