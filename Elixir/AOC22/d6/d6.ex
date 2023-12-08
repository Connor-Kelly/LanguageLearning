filepath = "../inputs/d6smol.txt"

# require FsDir

# File.read(filepath)
# |> elem(1)
# |> String.split("$ ")
# |> Enum.drop(1)
# |> IO.inspect()

root = %FsDir{name: "/"}
|> IO.inspect()

child = %FsDir{name: "child"}
|> IO.inspect()

root = root |> FsDir.addChild(child)
root |> IO.inspect()
#  |> Graph.getName() |> IO.inspect()

f1 = %FsFile{name: "file", size: 10}
root = root |> FsDir.addChild(f1) |> IO.inspect()
f2 = %FsFile{name: "file2", size: 30}
root = root |> FsDir.addChild(f2) |> IO.inspect()
root |> FsNode.getSize() |> IO.inspect()
