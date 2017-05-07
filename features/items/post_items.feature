@api_test @items
Feature: Test API POST Items

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
