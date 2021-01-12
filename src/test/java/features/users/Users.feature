Feature: Users API tests

  Background:
    * url 'https://limitless-ridge-11429.herokuapp.com/'

  Scenario: Create a new user and validate is created
    Given path 'users'
    And request {"name": "Jorge", "surname": "Des", "username": "JD", "dateOfBirth":"02-02-1999", "email": "jorge@automationqa.tech"}
    When method post
    Then status 201

    * def location = responseHeaders['Location'][0]

    Given url location
    When method get
    Then match response.email == "jorge@automationqa.tech"

  Scenario: Get all users and validate scheme

    * def isValidTime = read('../../helpers/time-validator.js')
    Given path 'users'
    When method get
    Then status 200
    And match response == '#[]'
    And match each response ==
    """
     {
     id: '#number',
     name: '#string',
     surname: '#string',
     username: '#string',
     dateOfBirth: '#? isValidTime(_)',
     email: '#string'
     }
    """

  Scenario: Create and Delete a user
    Given path 'users'
    And request
    """
    {
      "name": "Jorge",
      "surname": "Des",
      "username": "JD",
      "dateOfBirth": "13-06-1986",
      "email": "jorge@automationqa.tech"
    }
    """
    When method post
    Then status 201

    * def location = responseHeaders['Location'][0]

    Given url location
    When method get
    Then match response.email == "jorge@automationqa.tech"
