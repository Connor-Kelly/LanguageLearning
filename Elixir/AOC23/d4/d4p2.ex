# filepath = "../inputs/d4smol.txt"
filepath = "../inputs/d4full.txt"

counts =
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
  end)
  |> IO.inspect()

points =
  counts
  |> Enum.map(fn val ->
    if val > 0 do
      Integer.pow(2, val - 1)
    else
      0
    end
  end)
  |> IO.inspect()

# |> Enum.sum()
IO.puts("")
# points

bitArr =
  Enum.reduce(0..(length(counts) - 1), List.duplicate(1, length(counts)), fn index, acc ->
    val = min(Enum.at(counts, index), length(counts) - 1)
    [index: index, val: val, acc: acc]
    # |> IO.inspect()

    bounds =
      [f: min(index + 1, length(counts) - 1), l: min(index + val, length(counts) - 1)]

    # |> IO.inspect()

    if bounds[:f] != length(counts) - 1 do
      Enum.reduce(bounds[:f]..bounds[:l]//1, acc, fn x, acc2 ->
        val2 = Enum.at(acc, index)

        [val2: val2]
        # |> IO.inspect()

        [x: x, acc2: acc2]
        # |> IO.inspect()

        # IO.puts("")
        acc2 |> List.replace_at(x, Enum.at(acc2, x) + val2)
      end)
      # |> IO.inspect()
    else
      acc
    end

    # Enum.replace
    # acc + bitArr
  end)
  |> IO.inspect()

IO.puts("points: ")
points |> IO.inspect()
IO.puts("counts: ")
counts |> IO.inspect()
IO.puts("bitArr: ")

bitArr
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()

IO.puts("")

# Enum.map(0..(length(counts) - 1), fn x ->
#   Enum.at(points, x) * Enum.at(bitArr, x)
# end)
# |> IO.inspect()
# |> Enum.sum()
# |> IO.inspect()

# points |> Enum.reverse()
# |> IO.inspect()
# |> then(fn list ->
#   for x <- 0..(length(list) - 1) do
#     # x |> IO.inspect()
#     val = Enum.at(list, x) |> IO.inspect()
#     bounds = %{f: max(x - val, 0), l: max(x - 1, 0)} |> IO.inspect()

#     list
#     |> Enum.slice(bounds[:f]..bounds[:l]//1)
#     |> IO.inspect()

#     IO.puts("")
#   end
# end)
