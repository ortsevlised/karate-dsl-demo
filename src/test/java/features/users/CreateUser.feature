Feature: Creating a new user

  Background:
    * def dataGenerator = Java.type('helpers.DataGenerator')

    * def DbUtils = Java.type('helpers.DbUtils')
    * def config = { username: 'sa', password: '', url: 'jdbc:h2:tcp://localhost:9090/mem:testdb', driverClassName: 'org.h2.Driver' }
    * def db = new DbUtils(config)
    
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

  @debug
  Scenario: Create a new user and validate is created
    Given url apiUrl
    And path 'users'
    And request userDetails
    When method post
    Then status 201

    * def userLocation = responseHeaders['Location'][0]
    * def id = userLocation.substring(userLocation.lastIndexOf('/') + 1)

    Given path 'users/'+ id
    When method get
    Then status 200

  # since the DbUtils returns a Java Map, it becomes normal JSON here !
  # which means that you can use the full power of Karate's 'match' syntax
    * def userDetails = db.readRows('SELECT * FROM USER WHERE ID= '+ id)
    * print userDetails
