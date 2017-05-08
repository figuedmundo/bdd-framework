# author Edmundo Figueroa
@api_test @projects
Feature: Test API DELETE Projects

  @crud @test
  Scenario: Delete a project
    Given I have set a connection to application
    And I have basic authentication
    And I have a created Project with Content "Project_to_delete"
    And I want to store a property "$.Id" in "ProjectId"
    When I send a DELETE Item request to "/projects/[id].json" with Id "ProjectId"
    Then I expect HTTP code 200
