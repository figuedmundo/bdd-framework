
Given /^I have a created Project with Content "(.*?)"$/ do |contentProject|
  http_request = Rest_service.get_request('POST', '/projects.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = "{\"Content\":\"#{contentProject}\"}"
  http_request.basic_auth($app_user,$app_password) if @basic_auth

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

Then(/^I expect a list of "([^"]*)" projects in respose body$/) do |listProjects|
  json = JSON.parse(@last_json)
  listArray = listProjects.split(/\s*,\s*/).each_with_index do |project, i|
    expect(JsonPath.new("$[#{i}].Content").on(json).to_a.map(&:to_s)).to include(project)
  end
end

When /^I send a (PUT) request to "(.*)" with Id "(.*)" and json$/ do |method, end_point, id, json_text|
  end_point=end_point.gsub('[id]',@storeProperties[id])
  http_request = Rest_service.get_request(method, end_point)
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.basic_auth($app_user,$app_password) if @basic_auth

  http_request.body = json_text

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end
