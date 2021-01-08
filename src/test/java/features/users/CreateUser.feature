Feature: Creating a new user

Background:
  * def dataGenerator = Java.type('helpers.DataGenerator')

  * def userDetails =
    """
      {
        "name": '#(dataGenerator.getRandomName())',
        "surname": '#(dataGenerator.getRandomSurname())',
        "username": '#(dataGenerator.getRandomUsername())',
        "dateOfBirth": '#(dataGenerator.getRandomDob())',
        "email": '#(dataGenerator.getRandomEmail())',
      }
    """

  Scenario: Create a new user and validate is created
    Given url apiUrl
    And path 'users'
    And request userDetails
    When method post
    Then status 201

    * def userLocation = responseHeaders['Location'][0]

    Given url userLocation
    When method get
    Then status 200
