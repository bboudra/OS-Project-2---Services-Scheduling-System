Feature: Client views available times
  As a client
  I want to see the available times
  So that I may find a time to register for a service that fits my schedule

  Scenario: Client successfully views available times
    Given The available times for the date '12/27/2016' are from '2' to '4'
    When I ask to view the available times for the date '12/27/2016' for an appoint length of '1' hour
    Then I should receive the list of available times for that day
      | available times |
      | 1               |
      | 1:15            |
      | 1:30            |
      | 1:45            |
      | 2:00            |


