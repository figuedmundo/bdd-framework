@api_test @projects
Feature: Verify that the projects can be created with POST request

  @crud
  Scenario: Create a project
    Given I have set a connection to application
    And I have basic authentication
    When I send a POST request to /projects.json with json
      """
      {
        "Content":"Project created with POST request",
        "Icon":4
      }
      """
    And I want to store a property "$.Id" in "ProjectId"
    Then I expect HTTP code 200
    And I expect JSON response should have "$.Id" with a stored property "ProjectId"
    And I expect JSON response should have "$.Content" with the text "Project created with POST request"

  @negative
  Scenario: Create a project with invalid body
    Given I have set a connection to application
    And I have basic authentication
    When I send a POST request to /projects.json with json
      """
      {
        "Content":""
      }
      """
    Then I expect HTTP code 200
    And I expect JSON response should have "$.ErrorMessage" with the text "Too Short Project Name"
    And I expect JSON response should have "$.ErrorCode" with the text "305"
