defmodule CliParsingTest do
  use ExUnit.Case
  doctest CliParsing

  test "greets the world" do
    assert CliParsing.hello() == :world
  end
end
