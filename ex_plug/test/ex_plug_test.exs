defmodule ExPlugTest do
  use ExUnit.Case
  doctest ExPlug

  test "greets the world" do
    assert ExPlug.hello() == :world
  end
end
