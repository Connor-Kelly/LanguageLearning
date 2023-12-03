file = "../inputs/d3smol.txt"

defmodule Matrix do
  def search(mat) do
    IO.puts("Searching Matrix | ylen: #{length(mat)} xlen: #{length(mat |> Enum.at(0))}")
    search(mat, 0, 0, &Matrix.print(&1, &2, &3))
  end

  def search(mat, x, y, fun) do
    mat = apply(fun, [mat, x, y])

    cond do
      y == length(mat) - 1 && x == length(Enum.at(mat, 0)) - 1 -> mat
      x == length(Enum.at(mat, 0)) - 1 -> search(mat, 0, y + 1, fun)
      true -> search(mat, x + 1, y, fun)
    end
  end

  def print(mat, x, y) do
    if x == 0 do
      IO.write("\n")
    end

    IO.write("(#{x}, #{y}: ")
    IO.write("\"#{mat |> Enum.at(y) |> Enum.at(x)}\") ")
    mat
  end

  def symbolize(mat, x, y) do
    val = mat |> Enum.at(y) |> Enum.at(x) |> Integer.parse()

    symbol =
      val
      |> case do
        :error ->
          case mat |> Enum.at(y) |> Enum.at(x) do
            "." -> :.
            "#" -> :.
            "$" -> :.
            "%" -> :.
            "&" -> :.
            "*" -> :g
            "+" -> :.
            "-" -> :.
            "/" -> :.
            "=" -> :.
            "@" -> :.
            _ -> :u
          end

        {a, _} ->
          :n
      end

    List.replace_at(mat, y, List.replace_at(Enum.at(mat, y), x, symbol))
  end

  def adjuctize(mat, x, y) do
    mat
    |> Enum.at(y)
    |> Enum.at(x)
    |> case do
      :s ->
        List.foldl(Enum.to_list(-1..1), mat, fn j, acc ->
          List.foldl(Enum.to_list(-1..1), acc, fn i, acc2 ->
            Matrix.replace(acc2, x + i, y + j, :a)
          end)
        end)

      _ ->
        mat
    end
  end

  def replace(mat, x, y, val) do
    List.replace_at(mat, y, List.replace_at(Enum.at(mat, y), x, val))
  end

  def getLines(mat) do
    Enum.map(0..(length(mat) - 1), fn y ->
      # zippedLine = Enum.zip([Enum.at(vals, y), Enum.at(syms, y), Enum.at(adjs, y)])
      line = Enum.at(mat, y)
      getParts(line)
    end)

    # |> IO.inspect()
  end

  def getParts(line) do
    val =
      if length(line) > 0 do
        # IO.write("word: ")
        word =
          line
          |> Enum.take_while(fn n -> n |> Integer.parse() != :error end)
          |> Enum.to_list()
          |> List.to_string()
          |> then(fn str -> List.duplicate(str, String.length(str)) end)

        # |> IO.inspect()

        list =
          if length(word) == 0 do
            [""] ++ getParts(Enum.slice(line, 1..length(line)))
          else
            word ++ getParts(Enum.slice(line, length(word)..length(line)))
          end

        # wordValue =
        #   word
        #   |> Enum.any?(fn z -> elem(z, 2) == :a end)
        #   |> if do
        #     Enum.map(word, fn z -> elem(z, 0) end) |> to_string() |> Integer.parse() |> elem(0)
        #   else
        #     0
        #   end

        # wordValue + restOfLineValue
      else
        []
      end

    # val
  end

  def at(mat, x, y) do
    mat |> Enum.at(y) |> Enum.at(x)
  end
end

numMat =
  File.read(file)
  # |> IO.inspect()
  |> elem(1)
  |> String.split("\r\n")
  |> Enum.map(fn row -> String.split(row, "") |> Enum.slice(1..-2//1) end)

# |> IO.inspect()

numMat |> IO.inspect()

# numMat |> Matrix.search() |> IO.inspect()

symMat = numMat |> Matrix.search(0, 0, &Matrix.symbolize(&1, &2, &3)) |> IO.inspect()

adjMat = symMat |> Matrix.search(0, 0, &Matrix.adjuctize(&1, &2, &3)) |> IO.inspect()

gearCoords =
  symMat
  |> Enum.with_index()
  |> Enum.map(fn p ->
    {line, i} = p

    line
    |> Enum.with_index()
    |> Enum.map(fn p2 ->
      {elem, j} = p2
      {elem, {j, i}}
    end)
    |> Enum.filter(fn p2 ->
      {elem, j} = p2
      elem == :g
    end)
  end)
  |> List.flatten()
  |> Enum.map(fn p -> elem(p, 1) end)
  |> IO.inspect()

numMat = numMat |> Matrix.getLines() |> IO.inspect()

gearCoords
|> Enum.map(fn gc ->
  {x, y} = gc
  gc |> IO.inspect()
  # numMat |> Matrix.at(0, 4) |> IO.inspect()
  # if Matrix.at(numMat, x - 1, y) != "" do
  #   nums = [nums | Matrix.at(numMat, x - 1, y)]
  # end
  # if Matrix.at(numMat, x - 1, y - 1) != "" do
  #   nums = [nums | Matrix.at(numMat, x - 1, y)]
  # else
  #   Matrix.at(numMat, x - 1, y - 1) |> IO.puts()
  # end

  nums = []

  nums =
    if Matrix.at(numMat, x - 1, y) != "" do
      [Matrix.at(numMat, x - 1, y) | nums] |> IO.inspect()
    end
  nums =
    if Matrix.at(numMat, x + 1, y) != "" do
      [Matrix.at(numMat, x + 1, y) | nums] |> IO.inspect()
    end

  Enum.each(-1..1, fn j ->
    Enum.each(-1..1, fn i ->
      Matrix.at(numMat, x + i, y + j) |> IO.write()
      IO.write(" | ")
    end)

    IO.write("\n---------\n")
  end)

  nums |> IO.inspect()

  {gc, nums}
end)
|> IO.inspect()
