Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * def createUser = call read('classpath:features/users/CreateUser.feature')

  Scenario: Delete a user
    Given url createUser.userLocation
    When method delete
    Then status 200
    When method get
    Then status 404