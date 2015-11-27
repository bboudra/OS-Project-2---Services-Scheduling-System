Feature: Client views available times
  As a client
  I want to see the available times
  So that I may find a time to register for a service that fits my schedule

 Background:
   Given I am a client who wishes to use the system

 Scenario: Client successfully views available times
   When I ask to view the available times for the date '12/27/2016'
   Then I should receive the list of available times for that day


