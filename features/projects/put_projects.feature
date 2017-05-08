# author Edmundo Figueroa
@api_test @projects
Feature: Test API PUT Projects

@crud
Scenario: Update a project
  Given I have set a connection to application
  And I have basic authentication
  And I have a created Project with Content "Project_to_Update"
  And I want to store a property "$.Id" in "ProjectId"
  When I send a PUT request to "/projects/[id].json" with Id "ProjectId" and json
    """
    {
      "Content":"Project updated with PUT request",
      "Icon":4
    }
    """
  Then I expect HTTP code 200
  And I expect JSON response should have "$.Id" with a stored property "ProjectId"
  And I expect JSON response should have "$.Content" with the text "Project updated with PUT request"


  @negative
  Scenario: Update a project without basic authentication
    Given I have set a connection to application
    And I have basic authentication
    And I have a created Project with Content "Project_to_Update"
    And I want to store a property "$.Id" in "ProjectId"
    When I send a PUT request to "/projects/[id].json" with Id "ProjectId" and json
      """
      {
        "Content": 123,
        "Icon":false

      }
      """
    Then I expect Runtime Error
    # And I expect JSON response should have "$.ErrorMessage" with the text "Not Authenticated"
    # And I expect JSON response should have "$.ErrorCode" with the text "102"
