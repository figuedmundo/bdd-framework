@api_test
Feature: Test API GET authentication

@smoke 
Scenario:
  Given I have set a connection to application
  When I send a GET request to "/authentication/isauthenticated.json"
  Then I expect HTTP code 200

@smoke 
Scenario: Get 200 code response when get authentication token 
  Given I have set a connection to application
    And I have basic authentication
  When I send a GET request to "/authentication/token.json"
  Then I expect HTTP code 200