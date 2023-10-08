defmodule HeyTest do
  use ExUnit.Case
  doctest Hey

  test "greets the world" do
    assert Hey.hello() == :world
  end
end
