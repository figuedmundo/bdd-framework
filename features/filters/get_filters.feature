#Author: Maria Eloisa Alcocer Villarroel
Feature: Gets filters

# @smoke
# Scenario: Get status code 200 for filters service
# Given I have set a connection to application
#   And I have basic authentication
# When I send a GET request to "/filters.json"
# Then I expect HTTP code 200

# @crud
# Scenario: Validate that get all existing filter 
# Given I have set a connection to application
#   And I have basic authentication
#  When I send a GET request to "/filters.json"
#  Then I expect 

 @crud 
 Scenario Outline: Validate that the correct information of filter is obtained
 Given I have set a connection to application
  And I have basic authentication
 When I send a GET filter request to "/filters/[id].json" with id "-"
 Then I expect HTTP code 200
  And I expect JSON response should have "$.Id" with a stored property "-5"
  # And I expect JSON response should have "$.Content" with a stored property "Today"
  And I expect JSON response should have "$.Icon" with a stored property "16"
   # And I expect JSON response should have "$.ItemType" with a stored property "4"