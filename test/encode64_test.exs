defmodule Encode64Test do
  use ExUnit.Case
  doctest Encode64

  test "B is at 13th postion in itoa64" do
    assert Encode64.strpos("D") === 15
  end

  test "postion in itoa64" do
    assert Encode64.itoa64_masked_at(0) === "."
    assert Encode64.itoa64_masked_at(1) === "/"
    assert Encode64.itoa64_masked_at(10) === "8"
    assert Encode64.itoa64_masked_at(20) === "I"
    assert Encode64.itoa64_masked_at(63) === "z"
    assert Encode64.itoa64_masked_at(64) === "."
    assert Encode64.itoa64_masked_at(128) === "."
    assert Encode64.itoa64_masked_at(74) === "8"
  end
end
