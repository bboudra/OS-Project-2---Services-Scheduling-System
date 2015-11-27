#language: en
Feature: Client registers for service
  In order to have dental work done.
  As a client
  I want to register for a service

  Scenario: Client Successfully Registers
    Given I want to register for an appointment
    And The date-time combination is past the current date-time
    And The appointment will not overlap with an appointment that already exists
    When I register for an appointment
    Then I will receive a message saying that the registration was successful

