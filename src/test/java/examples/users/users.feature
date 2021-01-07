Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://limitless-ridge-11429.herokuapp.com/'

  Scenario: Create a new user
    Given path 'users'
    And request
    """
    {
      "name": "Jorge",
      "surname": "Des",
      "username": "JD",
      "dateOfBirth": "13/06/1986",
      "email": "jorge@automationqa.tech"
    }
    """
    When method post
    Then status 201

    * def location = responseHeaders['Location'][0]

    Given url location
    When method get
    Then match response.email == "jorge@automationqa.tech"

  Scenario: Get all users and validate scheme
    Given path 'users'
    When method get
    Then status 200
    And match response == '#array'
    And match each response ==
    """
     {
     id: '#number',
     name: '#string',
     surname: '#string',
     username: '#string',
     dateOfBirth: '#string',
     email: '#string'
     }
    """

