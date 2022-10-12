Feature: drupal-password-checker

  As a wordpress password checer,
  I would like to check password with encypted password stored in database.
  
  Scenario: right password	
    Given I start password checker
    When I input plain password "pass1234"
    And encrypted password is "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
    Then I should see "true"

  Scenario: wrong password	
    Given I start password checker
    When I input plain password "1234pass"
    And encrypted password is "$S$DyBV0HJZ5kDqbiGB9NZPKtRi6OJkVfyre7XvaEQQnvNmYb9api9I"
    Then I should see "false"
