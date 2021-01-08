Feature: Delete users
  Background:
    * def createUser = call read('classpath:features/users/CreateUser.feature')

  Scenario: Delete a user
    Given url createUser.userLocation
    When method delete
    Then status 200
    When method get
    Then status 404