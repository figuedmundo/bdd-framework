@api_test @items
Feature: Test API GET Items

# todo: In-progress LastSyncedDateTime is updated every time that we call to endpoint
@crud
Scenario: Get Item by Id for existing Item
Given I have set a connection to application
  And I have basic authentication
#  And I have an existing Item with Id 9874547
When I send a GET request to "/items/9874547.json"
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

@negative
Scenario: Get Item by Id for unexisting Item
Given I have set a connection to application
  And I have basic authentication
When I send a GET request to "/items/0.json"
Then I expect HTTP code 200
  And I expect JSON equal to
    """
    """
