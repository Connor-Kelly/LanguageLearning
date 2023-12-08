defmodule FsDir do
  defstruct name: "unnamed-dir", children: %{}, size: 0

  def getName(%FsDir{} = dir) do
    dir.name
  end

  def addChild(%FsDir{} = parent, %FsDir{} = child) do
    %FsDir{
      name: parent.name,
      children: parent.children |> Map.put(child.name, child),
      size: parent.size
    }
  end

  def addChild(%FsDir{} = parent, %FsFile{} = child) do
    %FsDir{
      name: parent.name,
      children: parent.children |> Map.put(child.name, child),
      size: parent.size
    }
  end

  def getSize(%FsDir{} = dir) do
    dir.children |> Map.keys() |> Enum.map(fn k -> Map.fetch(dir.children, k) end)
  end
end

defimpl FsNode, for: FsDir do
  def getSize(%FsDir{} = dir),
    do:
      dir.children
      |> Map.keys()
      |> Enum.map(fn k -> Map.fetch(dir.children, k) |> elem(1) |> FsNode.getSize() end)
      |> Enum.sum()
end

defmodule FsFile do
  defstruct name: "unnamed-file", size: 0

  def getSize(%FsFile{} = file) do
    file.size
  end
end

defprotocol FsNode do
  def getSize(obj)
end

defimpl FsNode, for: FsFile do
  def getSize(%FsFile{} = fileNode), do: fileNode.size
end

# defimpl Node do
#   def getSize(object)
# end
