#language: en
Feature: Client registers for service
  In order to have dental work done.
  As a client
  I want to register for a service
  @Incomplete
  Scenario: Client Successfully Registers
    Given I want to register for an appointment
    And The date-time combination is past the current date-time
    And The appointment will not overlap with an appointment that already exists
    When I register for an appointment
    Then I will receive a message saying that the message was successful
  @Incomplete
  Scenario: Client Unsuccessful due to time Conflict
    Given I want to register for an appointment
    And The date-time combination is past the current date-time.
    And The appointment will overlap with an appointment that already exists
    When I register for an appointment
    Then I will receive a message saying that the registration was not successful.
    And I will receive a message saying that there exists a conflicting appointment at that time.

  @Incomplete
  Scenario:
    Given I want to register for an appointment
    And The date-time combination is before or the same as the current date-time
    When I register for an appointment
