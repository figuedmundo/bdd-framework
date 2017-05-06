@api_test
Feature: Test API create user

@crud
Scenario:
Given I have set a connection to application
When I send a POST request to /user.json with json
"""
    {
  "UserObject": {
    	"Email": "use123r@email.com",
    	"FullName": "Joe Blow",
    	"Password": "pASswoRd"
	  }
	}
"""
Then I expect HTTP code 200
And I expect JSON equal to
      """
      {
       "ErrorMessage": "Invalid Email Address",
       "ErrorCode": 307
      }
      """



  Scenario:
  Given I have set a connection to application
  When I send a GET request to "/authentication/isauthenticated.json"
  Then I expect HTTP code 200

  Scenario:
  Given I have set a connection to application
  When I send a GET request to "/authentication/token.json"
  Then I expect HTTP code 200

  Scenario:
  Given I have set a connection to application
  When I send a GET request with token to "/projects.json"
  Then I expect HTTP code 200
