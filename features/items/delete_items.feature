#Author: Miguel Pari
@api_test @items
Feature: Test API DELETE Items

@crud
Scenario: Delete an existing item by Id of the Inbox
Given I have set a connection to application
  And I have basic authentication
  And I have a created Item in the Inbox with Content "Item to Delete"
  And I want to store a property "$.Id" in "ItemId"
When I send a DELETE Item request to "/items/[id].json" with Id "ItemId"
Then I expect HTTP code 200
  And I expect JSON response should have "$.Content" with the text "Item to Delete"
  And I expect JSON response should have "$.Id" with a stored property "ItemId"

@crud
Scenario: Delete an existing item by Id of a Project
Given I have set a connection to application
  And I have basic authentication
  And I have a created Project with Content "Project With Item"
  And I want to store a property "$.Id" in "ProjectId"
  And I have a created Item with Content "Item to Delete" in the Project with Id "ProjectId"
  And I want to store a property "$.Id" in "ItemId"
When I send a DELETE Item request to "/items/[id].json" with Id "ItemId"
Then I expect HTTP code 200
  And I expect JSON response should have "$.Content" with the text "Item to Delete"
  And I expect JSON response should have "$.Id" with a stored property "ItemId"
  And I expect JSON response should have "$.ProjectId" with a stored property "ProjectId"

@negative
Scenario: Delete an unexisting item by Id
Given I have set a connection to application
  And I have basic authentication
  When I send a DELETE Item request to "/items/[id].json" with Id "default"
Then I expect HTTP code 200
  And I expect JSON response should have "$.ErrorMessage" with the text "Invalid Id"
  And I expect JSON response should have "$.ErrorCode" with the text "301"
  And I expect JSON equal to
    """
    {
      "ErrorMessage": "Invalid Id",
      "ErrorCode": 301
    }
    """
