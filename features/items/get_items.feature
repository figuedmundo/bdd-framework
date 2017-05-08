#Author: Miguel Pari
@api_test @items
Feature: Test API GET Items

@crud
Scenario: Get Item by Id for existing Item
Given I have set a connection to application
  And I have basic authentication
  And I have a created Item in the Inbox with Content "Existing Item"
  And I want to store a property "$.Id" in "ItemId"
  And I want to store a property "$.ItemOrder" in "ItemOrder"
  And I want to store a date "currentDate" in "LastSyncedDateTime"
  And I want to store a property "$.CreatedDate" in "CreatedDate"
  And I want to store a property "$.LastUpdatedDate" in "LastUpdatedDate"
  And I want to store a property "$.OwnerId" in "OwnerId"
When I send a GET Item request to "/items/[id].json" with Id "ItemId"
Then I expect HTTP code 200
  And I expect JSON response should have "$.Id" with a stored property "ItemId"
  And I expect JSON response should have "$.Content" with the text "Existing Item"
  And I expect JSON response should have "$.ItemType" with the text "1"
  And I expect JSON response should have "$.Checked" with the text "false"
  And I expect JSON response should have "$.ProjectId" with the text ""
  And I expect JSON response should have "$.Path" with the text ""
  And I expect JSON response should have "$.Collapsed" with the text "false"
  And I expect JSON response should have "$.DateString" with the text ""
  And I expect JSON response should have "$.DateString" with the text ""
  And I expect JSON response should have "$.DateStringPriority" with the text "0"
  And I expect JSON response should have "$.Recurrence" with the text ""
  And I expect JSON response should have "$.ItemOrder" with a stored property "ItemOrder"
  And I expect JSON response should have "$.Priority" with the text "4"
  And I expect JSON response should start "$.LastSyncedDateTime" with a stored property "LastSyncedDateTime"
  And I expect JSON response should have "$.Children" with the text "[]"
  And I expect JSON response should have "$.DueDateTime" with the text ""
  And I expect JSON response should have "$.CreatedDate" with a stored property "CreatedDate"
  And I expect JSON response should have "$.LastCheckedDate" with the text ""
  And I expect JSON response should have "$.LastUpdatedDate" with a stored property "LastUpdatedDate"
  And I expect JSON response should have "$.Deleted" with the text "false"
  And I expect JSON response should have "$.SyncClientCreationId" with the text ""
  And I expect JSON response should have "$.DueTimeSpecified" with the text "true"
  And I expect JSON response should have "$.OwnerId" with a stored property "OwnerId"

  @crud
  Scenario: Get Item by Id for existing Item of a Project
  Given I have set a connection to application
    And I have basic authentication
    And I have a created Project with Content "Project With Item"
    And I want to store a property "$.Id" in "ProjectId"
    And I have a created Item with Content "Existing Item" in the Project with Id "ProjectId"
    And I want to store a property "$.Id" in "ItemId"
    And I want to store a property "$.ItemOrder" in "ItemOrder"
    And I want to store a date "currentDate" in "LastSyncedDateTime"
    And I want to store a property "$.CreatedDate" in "CreatedDate"
    And I want to store a property "$.LastUpdatedDate" in "LastUpdatedDate"
    And I want to store a property "$.OwnerId" in "OwnerId"
  When I send a GET Item request to "/items/[id].json" with Id "ItemId"
  Then I expect HTTP code 200
    And I expect JSON response should have "$.Id" with a stored property "ItemId"
    And I expect JSON response should have "$.Content" with the text "Existing Item"
    And I expect JSON response should have "$.ItemType" with the text "1"
    And I expect JSON response should have "$.Checked" with the text "false"
    And I expect JSON response should have "$.ProjectId" with a stored property "ProjectId"
    And I expect JSON response should have "$.Path" with the text ""
    And I expect JSON response should have "$.Collapsed" with the text "false"
    And I expect JSON response should have "$.DateString" with the text ""
    And I expect JSON response should have "$.DateString" with the text ""
    And I expect JSON response should have "$.DateStringPriority" with the text "0"
    And I expect JSON response should have "$.Recurrence" with the text ""
    And I expect JSON response should have "$.ItemOrder" with a stored property "ItemOrder"
    And I expect JSON response should have "$.Priority" with the text "4"
    And I expect JSON response should start "$.LastSyncedDateTime" with a stored property "LastSyncedDateTime"
    And I expect JSON response should have "$.Children" with the text "[]"
    And I expect JSON response should have "$.DueDateTime" with the text ""
    And I expect JSON response should have "$.CreatedDate" with a stored property "CreatedDate"
    And I expect JSON response should have "$.LastCheckedDate" with the text ""
    And I expect JSON response should have "$.LastUpdatedDate" with a stored property "LastUpdatedDate"
    And I expect JSON response should have "$.Deleted" with the text "false"
    And I expect JSON response should have "$.SyncClientCreationId" with the text ""
    And I expect JSON response should have "$.DueTimeSpecified" with the text "true"
    And I expect JSON response should have "$.OwnerId" with a stored property "OwnerId"

@negative
Scenario: Get Item by Id for unexisting Item
Given I have set a connection to application
  And I have basic authentication
When I send a GET Item request to "/items/[id].json" with Id "default"
Then I expect HTTP code 200
  And I expect JSON equal to
    """
    """
