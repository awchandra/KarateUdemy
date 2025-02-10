
Feature: Tests for sign up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    * url apiUrl

Scenario: New User Sign Up
    Given path 'users'
    And request 
    """
        {
            "user": 
            {
                "email": #(randomEmail),
                "password": #(userPassword), 
                "username": #(randomUsername)
            }
        }
    """
    When method Post
    Then status 201
    And match response ==
    """
        {
            "user": {
                "id": "#number",
                "email": #(randomEmail),
                "username": #(randomUsername),
                "bio": "##string",
                "image": "##string",
                "token": "#string"
            }
        }
    """

Scenario Outline: New User Sign Up Error

    Given path 'users'
    And request 
    """
        {
            "user": 
            {
                "email": "<email>",
                "password": "<password>", 
                "username": "<username>"
            }
        }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
    | email                   | password        | username          | errorResponse                                      |
    | #(randomEmail)          | #(userPassword) | karatetrain2      | {"errors":{"username":["has already been taken"]}} |
    | karatetrain123@test.com | #(userPassword) | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
    |                         | #(userPassword) | #(randomUsername) | {"errors":{"email":["can't be blank"]}}            |
    | #(randomEmail)          |                 | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |
    | #(randomEmail)          | #(userPassword) |                   | {"errors":{"username":["can't be blank"]}}         |
