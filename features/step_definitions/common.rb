When(/^I have basic authentication$/) do
  @basic_auth = true
end

Then(/^I expect Runtime Error$/) do
  expect(@last_json.to_s).to include("Runtime Error")
end
