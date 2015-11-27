Feature: Sign up for customer account
  As a customer
  I would like to sign up for a customer account
  So that i may user the customer services
  @iteration2
  Scenario: Sign up successful
    Given that I am not a customer
    And I choose the sign up option
    And The username that I choose is not taken
    When I enter my username
    And I enter my password
    Then I will receive a message saying that the login was successful
    And I will be able to log in