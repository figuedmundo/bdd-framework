#Hooks
#Hooks Filters and some items
#Author: Maria Alcocer
After('@teardownDeleteItems') do
	# @array_items = Array.new
	# #get connection
	# @http_connection = Rest_service.get_connection
	# @storeProperties = {}
	# @storeProperties.default='0'
 # # end_point=end_point.gsub('[id]',@storeProperties[projectId])
	# http_request = Rest_service.get_request("GET", "/items.json")
 #  	http_request.basic_auth($app_user,$app_password)
	# @http_response = Rest_service.execute_request(@http_connection, http_request)
	# @array_items = @http_response.body
	# p @array_items[10]
	# @array_items.each do |item| 
	# 	puts "ID OF ITEM: #{item}"
	# end



end

#Author: Alejandra Arteaga
After('@teardownDeleteUser') do
  @http_connection = Rest_service.get_connection
  http_request = Rest_service.get_request("DELETE", "/user/0.json")
  http_request.basic_auth($newEmail, $newPass) 
  @http_response = Rest_service.execute_request(@http_connection, http_request)
  @last_json = @http_response.body
  puts "#{$newEmail}"
  puts "#{$newPass}"
end