Feature: Error messages

  Scenario Outline: Error message when creating a user
    * def dataGenerator = Java.type('helpers.DataGenerator')

    Given url apiUrl
    And path 'users'
    And request
    """
      {
        "name": <name>,
        "surname": <surname>,
        "username": <username>,
        "dateOfBirth": <dob>,
        "email": <email>,
      }
    """
    When method post
    Then status 400
    And match response == {"timestamp": #string,"message":"Validation Failed","details":<details>}

    Examples:
      | details                                                                        | name                             | surname                             | username                             | dob                             | email                             |
      | '#(^^["username size must be between 1 and 30","username must not be blank"])' | #(dataGenerator.getRandomName()) | #(dataGenerator.getRandomSurname()) |                                      | #(dataGenerator.getRandomDob()) | #(dataGenerator.getRandomEmail()) |
      | ["name must not be blank"]                                                     |                                  | #(dataGenerator.getRandomSurname()) | #(dataGenerator.getRandomUsername()) | #(dataGenerator.getRandomDob()) | #(dataGenerator.getRandomEmail()) |
      | ["surname must not be blank"]                                                  | #(dataGenerator.getRandomName()) |                                     | #(dataGenerator.getRandomUsername()) | #(dataGenerator.getRandomDob()) | #(dataGenerator.getRandomEmail()) |
      | ["dateOfBirth must not be blank"]                                              | #(dataGenerator.getRandomName()) | #(dataGenerator.getRandomSurname()) | #(dataGenerator.getRandomUsername()) |                                 | #(dataGenerator.getRandomEmail()) |
      | ["email must not be blank"]                                                    | #(dataGenerator.getRandomName()) | #(dataGenerator.getRandomSurname()) | #(dataGenerator.getRandomUsername()) | #(dataGenerator.getRandomDob()) |                                   |
      | ["email must be a well-formed email address"]                                  | #(dataGenerator.getRandomName()) | #(dataGenerator.getRandomSurname()) | #(dataGenerator.getRandomUsername()) | #(dataGenerator.getRandomDob()) | invalidEmail                      |
      | ["username size must be between 1 and 30"]                                     | #(dataGenerator.getRandomName()) | #(dataGenerator.getRandomSurname()) | 1234567890123456789012345678900      | #(dataGenerator.getRandomDob()) | #(dataGenerator.getRandomEmail()) |

