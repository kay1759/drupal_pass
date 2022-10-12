# DrupalPass

Drupal Password Check for elixir

strict for a normal Drupal 7 password using sha512 only

Password generator is not included

## Installation

The package can be installed by adding `drupal_pass` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:drupal_pass, "~> 0.1.0"}
  ]
end
```

## Environment:
Programing environment is as below.

* Erlang 25.0
* Elixir 1.14.0

## Operating Instructions:
### Usage:
    DrupalPass.check_password(<plain_password>, <stored_password>)
	
return Boolean (true or flase)

### convert Authentication Logic on Phoenix

When login, user input the plain password.
```
if Bcrypt checkpass OK
      login
else
	if Drupal checkpass OK
		Save encrypted password using Bcrypt
		Login
	else
		Authentication Failure
```

## Test:
### Unit Test:
    mix test
	
### Acceptance Test:
    mix white_bread.run

## Licence:

[MIT]

## Author:

[Katsuyoshi Yabe](https://github.com/kay1759)


