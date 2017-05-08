#Author: Maria Eloisa Alcocer Villarroel
Feature: Gets filters
The filters exiting in the app is Inbox with id: 0, Today with id:1, Next with id: -5 and Recycle Bin with id:-3

@smoke
Scenario: Get status code 200 for filters service
Given I have set a connection to application
  And I have basic authentication
When I send a GET request to "/filters.json"
Then I expect HTTP code 200

@crud
Scenario Outline: Validate that get all existing filter for an authenticated user
Given I have set a connection to application
  And I have basic authentication
 When I send a GET request to "/filters.json"
 Then I expect HTTP code 200
 Then I expect JSON response should have "<content_position>" with the text "<filter_name>"
Examples:
|content_position|filter_name|
|$[0].Content|Inbox|
|$[1].Content|Today|
|$[2].Content|Next|
|$[3].Content|Recycle Bin|

 @crud 
 Scenario Outline: Validate that the correct information of filter is obtained
 Given I have set a connection to application
  And I have basic authentication
 When I send a GET filter request to "/filters/[id].json" with id "<filter_id>"
 Then I expect HTTP code 200
  And JSON response should have "$.Id" with a stored property "<filter_id>"
  And JSON response should have "$.Content" with a stored property "<content>"
  And JSON response should have "$.Icon" with a stored property "<icon>"
  And JSON response should have "$.ItemType" with a stored property "<item_type>"

 Examples:
 |filter_id	|content	|icon|item_type|
 | 0		|Inbox		|15	 |4		   |
 |-1		|Today		|16  |4		   |
 |-5		|Next		|20  |4		   |


 @crud
 Scenario: Get the list of Items within the given filter
 Given I have set a connection to application
 And I have basic authentication
 And I send a POST request to /items.json with json
 	"""
      {
        "Content":"new Item to Next filter","ProjectId":"-5","DueDate":""
      }
    """
 And I want to store a property "$.Id" in "item_id"
 When I send a GET filter request to "/filters/[id]/items.json" with id "-5"
 Then I expect HTTP code 200
  And I expect JSON response should have "$[0].Id" with a stored property "item_id"
 And I expect JSON response should have "$[0].Content" with the text "new Item to Next filter"

 @crud
 Scenario: Get the list of done Items within the given filter
 Given I have set a connection to application
 And I have basic authentication
 And I send a POST request to /items.json with json
 	"""
      {
        "Content":"new Item to done","ProjectId":"-5","DueDate":""
      }
    """
 And I want to store a property "$.Id" in "item_id"
And I send a PUT request to "/items/[id].json" with Id "item_id" and json
      """
      {
        "Checked":true
      }
      """
When I send a GET filter request to "/filters/[id]/doneitems.json" with id "-5"
Then I expect HTTP code 200
And I expect JSON response should have "$[0].Id" with a stored property "item_id"
And I expect JSON response should have "$[0].Content" with the text "new Item to done"
And I expect JSON response should have "$[0].Checked" with the text "true"

@negative @teardownDeleteItems
 Scenario: Get the list of done Items (item not done) within the given filter
Given I have set a connection to application
 And I have basic authentication
 And I send a POST request to /items.json with json
 	"""
      {
        "Content":"new Item not done","ProjectId":"-5","DueDate":""
      }
    """
 And I want to store a property "$.Id" in "item_id"
When I send a GET filter request to "/filters/[id]/doneitems.json" with id "-5"
Then I expect HTTP code 200
 And I expect JSON response should not have "$[0].Id" with a stored property "item_id"
 And I expect JSON response should not have "$[0].Content" with the text "new Item not done"
 And I expect JSON response should not have "$[0].Checked" with the text "true"



