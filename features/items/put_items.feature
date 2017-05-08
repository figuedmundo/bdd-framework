#Authors: Maria Alcocer and Miguel Pari
@items
Feature: Puts items

#Maria's scenarios
@crud @teardownDeleteItems
Scenario: Update an Item by Id
Given I have set a connection to application
  And I have basic authentication
  And I have a created Item in the Inbox with Content "new item"
  And I want to store a property "$.Id" in "item_id"
  And I want to store a property "$.ItemOrder" in "ItemOrder"
  And I want to store a date "currentDate" in "LastSyncedDateTime"
  And I want to store a property "$.CreatedDate" in "CreatedDate"
  And I want to store a property "$.LastUpdatedDate" in "LastUpdatedDate"
  And I want to store a property "$.OwnerId" in "OwnerId"
 When I send a PUT request to "/items/[id].json" with Id "item_id" and json
    """
    {
      "Content":"item updated",
       "Checked": "true"
    }
    """
 Then I expect HTTP code 200
  And I expect JSON response should have "$.Id" with a stored property "item_id"
  And I expect JSON response should have "$.Content" with the text "item updated"
  And I expect JSON response should have "$.Checked" with the text "true"

#Miguel's scenarios