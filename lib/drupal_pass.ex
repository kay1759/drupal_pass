import Bitwise

defmodule DrupalPass do
  @moduledoc """
  Drupal Password Check
  Based on 'includes/password.inc'
  """

  @invalid "*0"

  @drupal_hash_count 15
  @drupal_min_hash_count 7
  @drupal_max_hash_count 30
  @drupal_hash_length 55

  @doc """
  equivalent CheckPassword

  DrupaPass.check_password(<password>, <stored_hash>)
  return true or false
  """
  def check_password(password, stored_hash) do
    if String.length(password) > 4096 do
      false
    else
      hash = crypt_password(password, stored_hash)

      if String.slice(hash, 0, 1) == "*" do
        false
      else
        hash === stored_hash
      end
    end
  end

  @doc """
  encrypted and encoded password
  """
  defp crypt_password(password, stored_hash) do
    if String.length(stored_hash) != @drupal_hash_length do
      @invalid
    else
      id = String.slice(stored_hash, 0, 3)
      shift_count = get_hash_shift_count(stored_hash)

      cond do
        id != "$S$" ->
          @invalid

        shift_count < @drupal_min_hash_count || shift_count > @drupal_max_hash_count ->
          @invalid

        true ->
          prefix = String.slice(stored_hash, 0, 12)
          hash = get_password_hash(password, stored_hash)
          encode = Encode64.encode(hash)

          String.slice(prefix <> encode, 0, @drupal_hash_length)
      end
    end
  end

  @doc """
  password encryption
  """
  def get_password_hash(password, stored_hash) do
    salt = get_salt(stored_hash)
    count = get_hash_count(stored_hash)

    get_hash(:sha512, password, salt, count)
    |> :binary.bin_to_list()
  end

  @doc """
  extract salt from stored hash
  """
  def get_salt(stored_hash) do
    String.slice(stored_hash, 4, 8)
  end

  @doc """
  loop hasing password with salt
  """
  def get_hash(algo, password, salt, count) do
    Enum.reduce(
      0..count,
      salt,
      fn _, acc -> :crypto.hash(algo, acc <> password) end
    )
  end

  @doc """
  hashing count
  """
  defp get_hash_count(stored_hash) do
    1 <<< get_hash_shift_count(stored_hash)
  end

  @doc """
  hasing shift count
  """
  defp get_hash_shift_count(stored_hash) do
    stored_hash
    |> String.at(3)
    |> Encode64.strpos()
  end

  """
  fot test enviornment
  """

  if Mix.env() == :test do
    def test_crypt_password(password, stored_hash) do
      crypt_password(password, stored_hash)
    end

    def test_get_hash_count(stored_hash) do
      get_hash_count(stored_hash)
    end

    def test_get_hash_shift_count(stored_hash) do
      get_hash_shift_count(stored_hash)
    end
  end
end
