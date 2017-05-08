#Hooks
#Hooks for Filters and some items
#Author: Maria Alcocer
After('@teardownDeleteItems') do
	@http_connection = Rest_service.get_connection
	http_request = Rest_service.get_request("GET", "/items.json")
  	http_request.basic_auth($app_user,$app_password)
	@http_response = Rest_service.execute_request(@http_connection, http_request)

	JSON.parse(@http_response.body).each do |item|
		end_point = "/items/[id].json".gsub('[id]', item['Id'].to_s)
		http_request = Rest_service.get_request("DELETE", end_point)
		http_request.basic_auth($app_user,$app_password)
		@http_response = Rest_service.execute_request(@http_connection, http_request)
	end

	# Empty Recycle bin
	http_request = Rest_service.get_request("DELETE", "/Filters/-4/Items.json")
	http_request.basic_auth($app_user,$app_password)
	@http_response = Rest_service.execute_request(@http_connection, http_request)
	log("Teardown: @teardownDeleteItems...")
end

#Author: Alejandra Arteaga
After('@teardownDeleteUser') do
  @http_connection = Rest_service.get_connection
  http_request = Rest_service.get_request("DELETE", "/user/0.json")
  http_request.basic_auth($newEmail, $newPass) 
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  log("Teardown: @teardownDeleteUser...")
end

Before do |scenario|
	log("START SCENARIO: \"#{scenario.name}\"")
end

After do |scenario|
	log("FINISHED SCENARIO: \"#{scenario.name}\"")
end
