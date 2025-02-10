Feature: Add Likes

    Background: 
        * url apiUrl

    Scenario: Add Like
        Given path 'articles', slug, 'favorite'
        And request {}
        When method Post
        Then status 200
        * def likesCount = response.article.favoritesCount