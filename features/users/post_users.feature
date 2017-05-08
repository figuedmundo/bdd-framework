# author Alejandra Arteaga
@api_test @users
Feature: Test API POST user

@crud @teardownDeleteUser
Scenario: Create user wit valid information
Given I have set a connection to application
When I send a POST User request to /user.json with json
      """
        {
          "Email": "todo_ly_to_be_created@email.com",
          "FullName": "user test to be created",
          "Password": "pASswoRd"
        }
      """
  And I want to store a property "$.Email" in "EmailUser"
  And I want to store a property "$.FullName" in "FullNameUser"
Then I expect HTTP code 200
  And I expect JSON response should have "$.Email" with a stored property "EmailUser"
  And I expect JSON response should have "$.FullName" with a stored property "FullNameUser"

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