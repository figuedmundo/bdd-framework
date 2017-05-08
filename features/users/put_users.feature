# author Alejandra Arteaga
@api_test @users
Feature: Test API PUT user

@crud @teardownDeleteUser
Scenario: Update user information of an existing user
  Given I have set a connection to application
    And I have a created User with Email "todo_ly_to_be_updated@email.com"
  When I send a PUT User request to /user/0.json with json
        """
          {
            "Email": "newEmailToBeUpdated@email.com"
          }
        """
  Then I expect HTTP code 200
    And I expect JSON response should have "$.Email" with the text "newEmailToBeUpdated@email.com"