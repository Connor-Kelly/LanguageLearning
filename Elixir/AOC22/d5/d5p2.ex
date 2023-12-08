# filepath = "../inputs/d5smol.txt"
# numStacks = 3
filepath = "../inputs/d5full.txt"
numStacks = 9

f =
  File.read(filepath)
  |> elem(1)
  |> String.split("\r\n\r\n")
  |> IO.inspect()

initConf =
  f
  |> Enum.at(0)
  |> String.split("\r\n")
  |> IO.inspect()
  |> Enum.drop(-1)
  |> Enum.map(fn s ->
    # Enum.map(1..numStacks//3, fn str ->
    #   str
    # end)
    s
    |> String.split("")
    |> Enum.drop(2)
    |> Enum.take_every(4)
    # |>
    |> IO.inspect()
  end)
  |> IO.inspect()

initConf =
  Enum.reduce(initConf, List.duplicate([], numStacks), fn s, acc ->
    # [s: s, acc: acc] |> IO.inspect()

    Enum.map(0..(numStacks - 1), fn i ->
      (Enum.at(acc, i) ++ [Enum.at(s, i)])
      |> Enum.filter(fn t -> t != " " end)
    end)

    # acc
  end)
  |> IO.inspect()

commands =
  f
  |> Enum.at(1)
  |> String.split("\r\n")
  |> Enum.map(fn str ->
    l =
      String.split(str, " ")
      |> IO.inspect()
      |> Enum.drop(1)
      |> Enum.take_every(2)
      |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end)

    [move, from, to] = l
    [m: move, f: from - 1, t: to - 1]
    # |> IO.inspect()
  end)
  |> IO.inspect()

IO.puts("Begin command")

Enum.reduce(commands, initConf, fn command, conf ->
  command |> IO.inspect()
  conf |> IO.inspect()
  # moved =
  #   Enum.at(conf, command[:f])
  #   |> Enum.take(command[:m])
  #   # |> IO.inspect()

  to =
    (Enum.at(conf, command[:f]) |> Enum.take(command[:m])) ++
      Enum.at(conf, command[:t])

  from = Enum.at(conf, command[:f]) |> Enum.drop(command[:m])
  [from: from, to: to] |> IO.inspect()

  conf
  |> List.replace_at(command[:t], to)
  |> List.replace_at(command[:f], from)

  # conf
  # |> List.replace_at(a
  #   command[:t],
  #   Enum.at(conf, command[:f])
  #   |> ([Enum.take(command[:m])] ++ Enum.at(conf, command[:f]))
  # )
  # |> IO.inspect()
end)
|> IO.inspect()
