defmodule TextclientTest do
  use ExUnit.Case
  doctest Textclient

  test "greets the world" do
    assert Textclient.hello() == :world
  end
end
