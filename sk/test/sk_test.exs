defmodule SkTest do
  use ExUnit.Case
  doctest Sk

  test "greets the world" do
    assert Sk.hello() == :world
  end
end
