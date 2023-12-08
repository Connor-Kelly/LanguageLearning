filepath = "../inputs/d6smol.txt"
filepath = "../inputs/d6full.txt"

[time, distance] = File.read(filepath) |> elem(1) |> String.split("\r\n")

time = time |> String.split(~r/( )+/) |> Enum.drop(1) |> Enum.join("") |>  Integer.parse() |> elem(0)
distance = distance |> String.split(~r/( )+/) |> Enum.drop(1) |> Enum.join("") |> Integer.parse() |> elem(0)

[time: time, dist: distance] |> IO.inspect()

# Enum.zip(time, distance)
# |> Enum.map(fn p ->
#   t = p |> elem(0)
#   d = p |> elem(1)

  Enum.map(1..(time - 1), fn charge ->
    if charge * (time - charge) > distance do
      1
    else
      0
    end
  end)
  |> IO.inspect()
  |> Enum.sum()
  |> IO.inspect()
# end)
# |> IO.inspect()
# |> Enum.product()
# |> IO.inspect()
