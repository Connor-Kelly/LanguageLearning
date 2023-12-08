defmodule Snafu do
  def toDecimal(str) do
    case str do
      "0" <> rol -> 0 + (Snafu.toDecimal(rol) * 5)
      "1" <> rol -> 1 + (Snafu.toDecimal(rol) * 5)
      "2" <> rol -> 2 + (Snafu.toDecimal(rol) * 5)
      "-" <> rol -> -1 + (Snafu.toDecimal(rol) * 5)
      "=" <> rol -> -2 + (Snafu.toDecimal(rol) * 5)
      _ -> 0
    end
  end
  def toSnafu(int) do
    fl = Integer.floor_div(int, 5)
    m = Integer.mod(int, 5)
    case fl do
      0 -> Snafu.toSnafu(m)
      0 -> Snafu.toSnafu(m)
      0 -> Snafu.toSnafu(m)
      0 -> Snafu.toSnafu(m)
      0 -> Snafu.toSnafu(m)

    end
  end
end


# Snafu.toDecimal("1") |> IO.inspect()
"1=" |> String.reverse() |> Snafu.toDecimal |> IO.inspect()
"1=11-2" |> String.reverse() |> Snafu.toDecimal |> IO.inspect()
"1121-1110-1=0" |> String.reverse() |> Snafu.toDecimal |> IO.inspect()
# Snafu.toDecimal("1=") |> IO.inspect()
# Snafu.toDecimal("1-") |> IO.inspect()
Integer.
