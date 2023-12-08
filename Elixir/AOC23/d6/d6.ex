filepath = "../inputs/d6smol.txt"
filepath = "../inputs/d6full.txt"

[time, distance] = File.read(filepath) |> elem(1) |> String.split("\r\n")

time = time |> String.split(~r/( )+/) |> Enum.drop(1) |> Enum.map(fn i -> Integer.parse(i) |> elem(0) end)
distance = distance |> String.split(~r/( )+/) |> Enum.drop(1) |> Enum.map(fn i -> Integer.parse(i) |> elem(0) end)

[time: time, dist: distance] |> IO.inspect()

Enum.zip(time, distance)
|> Enum.map(fn p ->
  t = p |> elem(0)
  d = p |> elem(1)

  Enum.map(1..(t - 1), fn charge ->
    if charge * (t - charge) > d do
      1
    else
      0
    end
  end)
  |> IO.inspect()
  |> Enum.sum()
  |> IO.inspect()
end)
|> IO.inspect()
|> Enum.product()
|> IO.inspect()
