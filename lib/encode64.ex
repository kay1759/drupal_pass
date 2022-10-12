import Bitwise

defmodule Encode64 do
  @moduledoc """
  Drupal Password Check
  Based on 'includes/password.inc'
  """

  @itoa64 "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  @doc """
  encode64
  """
  def encode(hash) do
    case length(hash) do
      0 ->
        ""

      1 ->
        val0 = Enum.at(hash, 0)

        itoa64_masked_at(val0) <>
          itoa64_masked_at(val0 >>> 6)

      2 ->
        val0 = Enum.at(hash, 0)
        val1 = Enum.at(hash, 1)

        itoa64_masked_at(val0) <>
          itoa64_masked_at((256 * val1 + val0) >>> 6) <>
          itoa64_masked_at(val1 >>> 4)

      _ ->
        val0 = Enum.at(hash, 0)
        val1 = Enum.at(hash, 1)
        val2 = Enum.at(hash, 2)
        rest = Enum.slice(hash, 3, length(hash) - 3)

        itoa64_masked_at(val0) <>
          itoa64_masked_at((256 * val1 + val0) >>> 6) <>
          itoa64_masked_at((val2 * 256 + val1) >>> 4) <>
          itoa64_masked_at(val2 >>> 2) <>
          encode(rest)
    end
  end

  @doc """
  return itoa64
  equivalent $itoa64 in PHP
  """
  def itoa64() do
    @itoa64
  end

  @doc """
  equivalent $itoa64[$value & 0x3f] in PHP
  """
  def itoa64_masked_at(pos) do
    itoa64_at(pos &&& 0x3F)
  end

  @doc """
  equivalent $itoa64[$value] in PHP
  """
  def itoa64_at(pos) do
    String.slice(@itoa64, pos, 1)
  end

  @doc """
  equivalent strpos($itoa64, $str)
  """
  def strpos(str) do
    case :binary.match(@itoa64, str) do
      {count, _} -> count
      _ -> -1
    end
  end
end
