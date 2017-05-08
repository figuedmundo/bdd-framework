# author Alejandra Arteaga
@api_test @users
Feature: Test API POST user

@crud
Scenario: Create user wit valid information
Given I have set a connection to application
When I send a POST request to /user.json with json
      """
        {
          "Email": "todo_ly_to_be_created@email.com",
          "FullName": "user test to be created",
          "Password": "pASswoRd"
        }
      """
Then I expect HTTP code 200
  And I expect JSON response should have "$.Email" with the text "todo_ly_to_be_created@email.com"
  And I expect JSON response should have "$.FullName" with the text "user test to be created"
Then I delete a created User with Email "todo_ly_to_be_created@email.com" and Password "pASswoRd"

@negative 
Scenario: Create user wit invalid information
Given I have set a connection to application
When I send a POST request to /user.json with json
      """
        {
          "Email": "todo_ly_to_be_deletedemail.com",
          "FullName": "user test to be deleted",
          "Password": "pASswoRd"
        }
      """
Then I expect HTTP code 200
And I expect JSON equal to
      """
      {
       "ErrorMessage": "Invalid Email Address",
       "ErrorCode": 307
      }
      """