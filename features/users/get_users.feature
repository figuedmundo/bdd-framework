# author Alejandra Arteaga
@api_test @users
Feature: Test API GET user

@smoke
Scenario: Get a 200 response when get information for a authenticated user on the sytem
Given I have set a connection to application
  And I have basic authentication
When I send a GET request to "/user.json"
Then I expect HTTP code 200

@crud
Scenario: Get information for a authenticated user on the sytem
Given I have set a connection to application
  And I have basic authentication
When I send a GET User request to "/user.json"
Then I expect HTTP code 200
  And I expect JSON response should have "$.Email" with the text "todo.ly.user@gmail.com"
  And I expect JSON response should have "$.FullName" with the text "todo_ly_user"


@negative
Scenario: Get an error when get information for a not authenticated user on the sytem
Given I have set a connection to application
When I send a GET request to "/user.json"
Then I expect HTTP code 200
  And I expect JSON equal to
        """
           {
            "ErrorMessage": "Not Authenticated",
            "ErrorCode": 102
          }
        """
