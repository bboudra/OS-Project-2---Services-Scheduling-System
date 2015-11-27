#language: en
Feature: Client registers for service
  In order to have dental work done.
  As a client
  I want to register for a service

  Background: logged on
    Given I am a client who wishes to use the system

  Scenario: Client Successfully Registers
    Given I attempt to register for an appointment after the date-time combination is past the current date-time
    And The appointment will not overlap with an appointment that already exists
    When I register for an appointment
    Then I will receive a message saying that the registration was successful

