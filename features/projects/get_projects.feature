# author Edmundo Figueroa
@api_test @projects
Feature: Test API GET Projects

  @smoke
  Scenario: Make sure that projects endpoint is alive
    Given I have set a connection to application
    When I send a GET request to "/projects.json"
    Then I expect HTTP code 200

  @crud
  Scenario: Get List of projects in response body with status 200
    Given I have set a connection to application
    And I have basic authentication
    When I send a GET request to "/projects.json"
    Then I expect HTTP code 200
    And I expect a list of "Work, Home ,Study ,Personal ,Shopping List" projects in respose body

  @crud
  Scenario: Get a project in response body with status 200
    Given I have set a connection to application
    And I have basic authentication
    And I have a created Project with Content "Project_Custom"
    And I want to store a property "$.Id" in "ProjectId"
    When I send a GET Item request to "/projects/[id].json" with Id "ProjectId"
    Then I expect HTTP code 200
    And I expect JSON response should have "$.Id" with a stored property "ProjectId"
    And I expect JSON response should have "$.Content" with the text "Project_Custom"

  @crud
  Scenario: Get a list of items that belongs to a project
    Given I have set a connection to application
    And I have basic authentication
    And I have a created Project with Content "Project_with_items"
    And I want to store a property "$.Id" in "ProjectId"
    And I have a created Item with Content "Item001_content" in the Project with Id "ProjectId"
    And I want to store a property "$.Id" in "ItemId001"
    And I have a created Item with Content "Item002_content" in the Project with Id "ProjectId"
    And I want to store a property "$.Id" in "ItemId002"
    When I send a GET Item request to "/projects/[id]/items.json" with Id "ProjectId"
    Then I expect HTTP code 200
    And I expect JSON response should have "$[0].Id" with a stored property "ItemId001"
    And I expect JSON response should have "$[0].Content" with the text "Item001_content"
    And I expect JSON response should have "$[1].Id" with a stored property "ItemId002"
    And I expect JSON response should have "$[1].Content" with the text "Item002_content"
