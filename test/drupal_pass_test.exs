defmodule DrupalPassTest do
  use ExUnit.Case
  doctest DrupalPass

  test "right password return true" do
    assert DrupalPass.check_password(
             "pass1234",
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) === true
  end

  test "wrong password return false" do
    assert DrupalPass.check_password(
             "1234pass",
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) === false
  end

  test "right password return a string the same as the second argument" do
    assert DrupalPass.test_crypt_password(
             "pass1234",
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
  end

  test "wrong password return a string different from the second argument" do
    assert DrupalPass.test_crypt_password(
             "1234pass",
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) !==
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
  end

  test "encrypted not start with '$S$' get '*0'" do
    assert DrupalPass.test_crypt_password(
             "pass1234",
             "$A$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             "*0"
  end

  test "encription count '9' get 2048" do
    assert DrupalPass.test_get_hash_count(
             "$S$9yBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             2048
  end

  test "encription count 'D' get 32768" do
    assert DrupalPass.test_get_hash_count(
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             32768
  end

  test "encription shift count '9' get 11" do
    assert DrupalPass.test_get_hash_shift_count(
             "$S$9yBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             11
  end

  test "encription shift count 'D' get 15" do
    assert DrupalPass.test_get_hash_shift_count(
             "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
           ) ===
             15
  end
end
