

filepath = "../inputs/d8smol.txt"

File.read(filepath) |> elem(1) |> String.split("\r\n") |> IO.inspect()
