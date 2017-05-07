@api_test
Feature: Test API POST user

@crud @test
Scenario: Create user wit valid information
Given I have set a connection to application
When I send a POST request to /user.json with json
      """
        {
          "Email": "todo_ly_to_be_deleted@email.com",
          "FullName": "user test to be deleted",
          "Password": "pASswoRd"
        }
      """
Then I expect HTTP code 200
And I expect JSON equal to
      """
          {
          "Id": 588389,
          "Email": "todo_ly_to_be_deleted@email.com",
          "Password": null,
          "FullName": "user test to be deleted",
          "TimeZone": 0,
          "IsProUser": false,
          "DefaultProjectId": 3647078,
          "AddItemMoreExpanded": false,
          "EditDueDateMoreExpanded": false,
          "ListSortType": 0,
          "FirstDayOfWeek": 0,
          "NewTaskDueDate": -1,
          "TimeZoneId": "Pacific Standard Time"
        }
      """
When I delete user created

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