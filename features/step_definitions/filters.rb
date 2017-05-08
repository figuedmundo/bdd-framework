#Author: MAria Eloisa Alcocer Villarroel

When(/^I send a (GET|DELETE) filter request to "([^"]*)" with id "([^"]*)"$/) do |method, end_point, filter_id|
	puts "FILTER_ID #{filter_id}"
  end_point = end_point.gsub('[id]',filter_id.to_s)
  puts "ENPOINT: #{end_point}"
  http_request = Rest_service.get_request(method, end_point)
  if @basic_auth then http_request.basic_auth($app_user,$app_password) end

  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts @http_response.body
end


Then(/^JSON response should have "([^"]*)" with a stored property "([^"]*)"$/) do |json_path, nameProperty|
  puts @last_json
  json=JSON.parse(@last_json)
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  expect(results).to include(nameProperty)
end
