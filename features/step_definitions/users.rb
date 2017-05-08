Given /^I have a created User with Email "(.*?)"$/ do |email|
  @newEmail = email
  @newPass = "pASswoRd"
  http_request = Rest_service.get_request('POST', '/user.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.body = 
  		"{
          \"Email\": \"#{@newEmail}\",
          \"FullName\": \"testUser\",
          \"Password\": \"#{@newPass}\"
        }"
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end

When /^I send a (DELETE) User request to "(.*)"$/ do |method,end_point|
  http_request = Rest_service.get_request(method, end_point)
  http_request.basic_auth(@newEmail, @newPass) 
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts @last_json
end

When /^I send a (GET) User request to "(.*)"$/ do |method,end_point|
  http_request = Rest_service.get_request(method, end_point)
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end 
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts @last_json
end

Given /^I delete a created User with Email "(.*?)" and Password "(.*?)"$/ do |email, password|
  http_request = Rest_service.get_request('DELETE', '/user/0.json')
  http_request['content-type'] = 'application/json'
  http_request['accept'] = 'application/json'
  http_request.basic_auth(email, password) 
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
end