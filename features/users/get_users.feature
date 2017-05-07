@api_test
Feature: Test API GET user

@smoke
Scenario: Get a 200 response when get information for a authenticated user on the sytem
Given I have set a connection to application
  And I have basic authentication
When I send a GET request to "/user.json"
Then I expect HTTP code 200

@crud @test01
Scenario: Get information for a authenticated user on the sytem
Given I have set a connection to application
  And I have basic authentication
When I send a GET request to "/user.json"
  And I keep the "Id" as "$id" from JSON response
Then I expect HTTP code 200
And I expect JSON equal to
      """
        {
          "Id": 588384,
          "Email": "todo.ly.user@gmail.com",
          "Password": null,
          "FullName": "todo_ly_user",
          "TimeZone": 0,
          "IsProUser": false,
          "DefaultProjectId": 3647048,
          "AddItemMoreExpanded": false,
          "EditDueDateMoreExpanded": false,
          "ListSortType": 0,
          "FirstDayOfWeek": 0,
          "NewTaskDueDate": -1,
          "TimeZoneId": "Pacific Standard Time"
        }
      """

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
