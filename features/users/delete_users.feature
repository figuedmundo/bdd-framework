# author Alejandra Arteaga
@api_test @users
Feature: Test API DELETE User

  @crud
  Scenario: Delete an existing user
    Given I have set a connection to application
    	And I have a created User with Email "todo_ly_to_be_deleted_test@email.com"
    When I send a DELETE User request to "/user/0.json"
    Then I expect HTTP code 200
    	And I expect JSON response should have "$.Email" with the text "todo_ly_to_be_deleted_test@email.com"