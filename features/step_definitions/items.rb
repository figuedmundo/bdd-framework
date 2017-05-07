
Given /^I have a created Item in the Inbox with Content "(.*?)"$/ do |contentItem|
  http_request = Rest_service.get_request('POST', '/items.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = "{\"Content\":\"#{contentItem}\"}"
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

Given /^I have a created Item with Content "(.*)" in the Project with Id "(.*)"$/ do |contentItem,projectId|
  http_request = Rest_service.get_request('POST', '/items.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = "{\"Content\":\"#{contentItem}\",\"ProjectId\":#{@storeProperties[projectId]}}"
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

Given /^I want to store a property "([^"]*)" in "(.*)"$/ do |json_path,nameProperty|
  jsonProject=JSON.parse(@last_json)
  property = JsonPath.new(json_path).on(jsonProject).to_a.map(&:to_s)
  @storeProperties[nameProperty]=property[0]
end

Given /^I want to store a date "([^"]*)" in "(.*)"$/ do |value,nameProperty|
  @storeProperties[nameProperty]="/Date(#{DateTime.now.strftime('%s').to_s[0,6]}"
end

When /^I send a (GET|DELETE) Item request to "(.*)" with Id "(.*)"$/ do |method,end_point,projectId|
  end_point=end_point.gsub('[id]',@storeProperties[projectId])
  http_request = Rest_service.get_request(method, end_point)
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

Then /^I expect JSON response should have "(.*)" with a stored property "(.*)"$/  do |json_path, nameProperty|
  json=JSON.parse(@last_json)
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  expect(results).to include(@storeProperties[nameProperty])
end

Then /^I expect JSON response should start "(.*)" with a stored property "(.*)"$/  do |json_path, nameProperty|
  json=JSON.parse(@last_json)
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  expect(results[0]).to start_with(@storeProperties[nameProperty])
end
