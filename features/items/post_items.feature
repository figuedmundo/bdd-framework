#Authors: Maria Alcocer and Miguel Pari
@api_test @items
Feature: Test API POST Items

#Miguel's scenarios
@crud
Scenario: Create Items with the same Content in the inbox
  Given I have set a connection to application
    And I have basic authentication
    And I have a created Item in the Inbox with Content "Duplicated Item"
    And I want to store a property "$.Id" in "ItemId"
    And I want to store a property "$.Content" in "ItemContent"
  When I send a POST request to /items.json with json
      """
        {
          "Content": "Duplicated Item"
        }
      """
  Then I expect HTTP code 200
    And I expect JSON response should have "$.Content" with a stored property "ItemContent"
    And I expect JSON response should be different "$.Id" with a stored property "ItemId"


#Maria's scenarios
@crud @teardownDeleteItems
Scenario: Create a new item in the inbox
 Given I have set a connection to application
   And I have basic authentication
   And I send a POST request to /items.json with json
  """
      {
        "Content":"new Item on Inbox","ProjectId":"0","DueDate":""
      }
    """
   And I want to store a property "$.Id" in "item_id"
  When I send a GET filter request to "/filters/[id]/doneitems.json" with id "0" # 0 is the static id for Inbox
  Then I expect HTTP code 200
   And I expect JSON response should have "$[0].Id" with a stored property "item_id"
   And I expect JSON response should have "$[0].Content" with the text "new Item on Inbox"