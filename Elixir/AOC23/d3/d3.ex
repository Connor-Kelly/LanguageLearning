file = "../inputs/d3full.txt"

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
            "#" -> :s
            "$" -> :s
            "%" -> :s
            "&" -> :s
            "*" -> :s
            "+" -> :s
            "-" -> :s
            "/" -> :s
            "=" -> :s
            "@" -> :s
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

  def getLines(vals, syms, adjs) do
    Enum.map(0..length(vals)-1, fn y ->
      zippedLine = Enum.zip([Enum.at(vals, y), Enum.at(syms, y), Enum.at(adjs, y)])
      getParts(zippedLine)
    end)
    |> IO.inspect()
  end

  def getParts(zippedLine) do
    # vals |> IO.inspect()
    # syms |> IO.inspect()
    # adjs |> IO.inspect()
    # z = List.zip([vals, syms, adjs]) |> IO.inspect()
    # val = 0
    # IO.inspect(zippedLine)

    val =
      if length(zippedLine) > 0 do
        word =
          zippedLine
          |> Enum.take_while(fn v -> elem(v, 1) == :n end)

        # |> IO.inspect()
        restOfLineValue = if length(word) == 0 do
          restOfLineValue = getParts(Enum.slice(zippedLine, 1..length(zippedLine)))
        else
          restOfLineValue = getParts(Enum.slice(zippedLine, length(word)..length(zippedLine)))
        end

        # IO.puts("rolv: #{restOfLineValue}")

        wordValue =
          word
          |> Enum.any?(fn z -> elem(z, 2) == :a end)
          |> if do
            Enum.map(word, fn z -> elem(z, 0) end) |> to_string() |> Integer.parse() |> elem(0)
          else
            0
          end

        # (wordValue + restOfLineValue) |> IO.inspect()

        wordValue + restOfLineValue
      else
        0
      end

    val
  end
end

numMat =
  File.read(file)
  # |> IO.inspect()
  |> elem(1)
  |> String.split("\r\n")
  |> Enum.map(fn row -> String.split(row, "") |> Enum.slice(1..-2//1) end)

# |> IO.inspect()

# numMat |> IO.inspect()

# numMat |> Matrix.search() |> IO.inspect()

symMat = numMat |> Matrix.search(0, 0, &Matrix.symbolize(&1, &2, &3)) |> IO.inspect()

adjMat = symMat |> Matrix.search(0, 0, &Matrix.adjuctize(&1, &2, &3)) |> IO.inspect()

%{value: numMat, symbol: symMat, adjacency: adjMat}
|> IO.inspect()

Matrix.getLines(numMat, symMat, adjMat) |> Enum.sum() |> IO.inspect()
