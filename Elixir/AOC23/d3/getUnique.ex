

f = File.read("../inputs/d3full.txt") |> elem(1)

l = f |> String.split("") |> Enum.sort() |> Enum.dedup()

l |> IO.inspect()
