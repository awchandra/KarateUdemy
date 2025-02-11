
Feature: Articles Test

Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleContent().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleContent().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleContent().body

    
    Scenario: Create and delete article      
        Given path 'articles/'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given path 'articles/',articleId
        When method Delete
        Then status 204