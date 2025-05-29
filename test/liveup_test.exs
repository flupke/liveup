defmodule LiveupTest do
  use ExUnit.Case
  doctest Liveup

  test "greets the world" do
    assert Liveup.hello() == :world
  end
end
