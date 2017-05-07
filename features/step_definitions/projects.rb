
Given /^I have a created Project wth Content "(.*?)"$/ do |contentProject|
  http_request = Rest_service.get_request('POST', '/projects.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = "{\"Content\":\"#{contentProject}\"}"
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end
