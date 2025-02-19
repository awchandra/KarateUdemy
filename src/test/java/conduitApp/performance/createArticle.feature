
Feature: Articles Test

Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = __gatling.Title
    * set articleRequestBody.article.description = __gatling.Description
    # * set articleRequestBody.article.title = dataGenerator.getRandomArticleContent().title
    # * set articleRequestBody.article.description = dataGenerator.getRandomArticleContent().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleContent().body

    
    Scenario: Create and delete article     
        * configure headers = {"Authorization": #('Token ' + __gatling.token)} 
        Given path 'articles/'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        # * karate.pause(5000)

        # Given path 'articles/',articleId
        # When method Delete
        # Then status 204