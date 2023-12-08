filename = "../inputs/d7test.txt"
filename = "../inputs/d7smol.txt"
filename = "../inputs/d7full.txt"

handPrecedenceStr = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
handPrecedence = [:A, :K, :Q, :T, :"9", :"8", :"7", :"6", :"5", :"4", :"3", :"2", :J]

getPrec = fn str ->
  handPrecedence
  |> Enum.find_index(fn c -> c == str end)
end

# |> IO.inspect()
handlist =
  File.read(filename)
  |> elem(1)
  |> String.split("\r\n")
  |> Enum.map(fn s -> s |> String.split(" ") end)
  |> IO.inspect()

handlist
|> Enum.map(fn handPair ->
  hand = handPair |> Enum.at(0) |> IO.inspect()

  hand
  |> String.split("")
  |> Enum.drop(-1)
  |> Enum.drop(1)
  |> Enum.sort()
  |> Enum.reduce([], fn card, acc ->
    key = ~w(#{card})a |> Enum.at(0)
    # |> IO.inspect()

    prio =
      acc
      |> Keyword.get_and_update(key, fn x ->
        if x == nil do
          {x, 1}
        else
          {x, x + 1}
        end
      end)
      |> elem(1)
  end)
  |> IO.inspect()
  |> then(fn kwList ->
    numJ = Keyword.get(kwList, :J, 0)

    wildAdd =
      kwList
      |> Keyword.drop([:J])
      |> Enum.max(
        fn a, b ->
          # [a: a, b: b] |> IO.inspect()
          # [ai: getPrec.(elem(a, 0)), bi: getPrec.(elem(b, 0))] |> IO.inspect()
          cond do
            elem(a, 1) == elem(b, 1) -> getPrec.(elem(a, 0)) < getPrec.(elem(b, 0))
            true -> elem(a, 1) > elem(b, 1)
          end

          # |> IO.inspect()
          # getPrec.(elem(a, 0)) < getPrec.(elem(b, 0))
        end,
        fn -> {:J, 0} end
      )
      # |> IO.inspect()
      # |> then(fn w -> if w == nil, do: , else: w end)
      |> IO.inspect()

    kwList =
      kwList
      |> Keyword.drop([:J])

    kwList =
      if Enum.empty?(kwList) do
        [J: 0]
      else
        kwList
      end

    kwList
    |> Keyword.get_and_update(elem(wildAdd, 0), fn x -> {x, x + numJ} end)
    |> elem(1)
    |> IO.inspect()

    # IO.puts("max ^")
    # kwList
  end)
  |> Keyword.values()
  |> Enum.sort()
  |> Enum.reverse()
  |> IO.inspect()
  |> case do
    [5] ->
      [hand, handPair |> Enum.at(1), {:fiveOKind, 7}]

    [4] ++ _ ->
      [hand, handPair |> Enum.at(1), {:fourOKind, 6}]

    [3, 2] ++ _ ->
      [hand, handPair |> Enum.at(1), {:fullHouse, 5}]

    [3] ++ _ ->
      [hand, handPair |> Enum.at(1), {:threeOKind, 4}]

    [2, 2] ++ _ ->
      [hand, handPair |> Enum.at(1), {:twoPair, 3}]

    [2] ++ _ ->
      [hand, handPair |> Enum.at(1), {:onePair, 2}]

    [1] ++ _ ->
      [hand, handPair |> Enum.at(1), {:highCard, 1}]

    _ ->
      [hand, handPair |> Enum.at(1), {:unknown, 0}]
  end
  |> IO.inspect()

  # [hand: hand, prio: prio]
end)
|> IO.inspect()
|> Enum.sort(fn a, b ->
  prio = {a |> Enum.at(2) |> elem(1), b |> Enum.at(2) |> elem(1)}
  # |> IO.inspect()
  cond do
    elem(prio, 0) < elem(prio, 1) ->
      true

    elem(prio, 0) > elem(prio, 1) ->
      false

    elem(prio, 0) == elem(prio, 1) ->
      hands =
        [
          a |> Enum.at(0) |> String.split("") |> Enum.drop(1) |> Enum.drop(-1),
          b |> Enum.at(0) |> String.split("") |> Enum.drop(1) |> Enum.drop(-1)
        ]
        |> Enum.zip()
        |> IO.inspect()

      Enum.find(hands, 0, fn cardPair ->
        elem(cardPair, 0) != elem(cardPair, 1)
      end)
      # |> IO.inspect()
      |> then(fn p ->
        aIndex =
          handPrecedenceStr
          |> Enum.find_index(fn c -> c == elem(p, 0) end)

        # |> IO.inspect()

        bIndex =
          handPrecedenceStr
          |> Enum.find_index(fn c -> c == elem(p, 1) end)

        # |> IO.inspect()

        (aIndex > bIndex)
        |> IO.inspect()
      end)

      # false
  end

  # a |> Enum.at(2) |> elem(1) < b |> Enum.at(2) |> elem(1)
end)
|> IO.inspect()
|> Enum.with_index(1)
|> IO.inspect()
|> Enum.map(fn p -> (elem(p, 0) |> Enum.at(1) |> Integer.parse() |> elem(0)) * elem(p, 1) end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
