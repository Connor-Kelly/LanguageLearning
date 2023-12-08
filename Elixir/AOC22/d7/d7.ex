filepath = "../inputs/d7smol.txt"
filepath = "../inputs/d7full.txt"

forest =
  File.read(filepath)
  |> elem(1)
  |> String.split("\r\n")
  |> Enum.map(fn s -> String.split(s, "") |> Enum.drop(1) |> Enum.drop(-1) end)
  |> IO.inspect()

height = forest |> length()
width = forest |> Enum.at(0) |> length()

[height: height, width: width] |> IO.inspect()

Enum.map(1..(height - 2), fn y ->
  # Enum.at(forest, y) |> IO.inspect()

  Enum.map(1..(width - 2), fn x ->
    my_height = Enum.at(forest, y) |> Enum.at(x)
    [h: my_height, x: x, y: y] |> IO.inspect()
    top = Enum.all?(0..(y - 1), fn j -> Enum.at(forest, j) |> Enum.at(x) < my_height end)

    bottom =
      Enum.all?((y + 1)..(height - 1)//1, fn j -> Enum.at(forest, j) |> Enum.at(x) < my_height end)

    left = Enum.all?(0..(x - 1), fn i -> Enum.at(forest, y) |> Enum.at(i) < my_height end)

    right =
      Enum.all?((x + 1)..(width -  1)//1, fn i -> Enum.at(forest, y) |> Enum.at(i) < my_height end)

    [top: top, bottom: bottom, left: left, right: right] |> IO.inspect()

    [top, bottom, left, right]
    |> Enum.any?(fn t -> t end)
    |> IO.inspect()
    |> case do
      true -> 1
      false -> 0
    end
  end)
  |> Enum.sum()
  |> IO.inspect()
end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
|> then(fn interior ->
  interior + (2 * height) + (2 * width) - 4
end)
|> IO.inspect()
