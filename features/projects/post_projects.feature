@api_test
Feature: Test API create project

@crud
Scenario:
Given I have set a connection to application
  And I have basic authentication
When I send a POST request to /projects.json with json
 """
{
  "Content":"testAle01123 from",
  "Icon":4
}
 """
 
 Then I expect HTTP code 200
 # And I expect JSON equal to
 #       """
 #       {
 #        "ErrorMessage": "Invalid Email Address",
 #        "ErrorCode": 307
 #      }
 #       """
