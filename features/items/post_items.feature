@api_test @items
Feature: Test API POST Items

@crud
# todo: Sample
Scenario: Create a new item in the inbox
Given I have set a connection to application
  And I have basic authentication
When I send a POST request to /items.json with json
    """
      {
        "Content": "[MP] New Item 02"
      }
    """
Then I expect HTTP code 200
  And I expect JSON equal to
    """
      {
      "Id": 9874547,
      "Content": "Existing Item",
      "ItemType": 1,
      "Checked": false,
      "ProjectId": null,
      "ParentId": null,
      "Path": "",
      "Collapsed": false,
      "DateString": null,
      "DateStringPriority": 0,
      "DueDate": "",
      "Recurrence": null,
      "ItemOrder": 7,
      "Priority": 4,
      "LastSyncedDateTime": "/Date(1494074713653)/",
      "Children": [],
      "DueDateTime": null,
      "CreatedDate": "/Date(1494073545780)/",
      "LastCheckedDate": null,
      "LastUpdatedDate": "/Date(1494073545780)/",
      "Deleted": false,
      "Notes": "",
      "InHistory": false,
      "SyncClientCreationId": null,
      "DueTimeSpecified": true,
      "OwnerId": 548885
      }
    """

@undefined
Scenario: Create Items with the same Content in the inbox
  Given I have set a connection to application
    And I have basic authentication
  When I send a POST request to /items.json with json
      """
        {
          "Content": "Duplicated Item"
        }
      """
    And I send a POST request to /items.json with json
        """
          {
            "Content": "Duplicated Item"
          }
        """
  Then I expect HTTP code 200
    And I expect JSON response should have "$.Content" with the text "Duplicated Item"
