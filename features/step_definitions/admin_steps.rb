Given /^the following users exist:$/ do |table|
	table.hashes.each do |user|
		User.create user
  end
end

Given /^I am logged in as Stephanie$/ do
	step 'I am on the login page'
	step 'I fill in "user_email" with "Stephanie"'
	step 'I fill in "user_password" with "mypassword"'
	step 'I press "Login"'
end

When /^I log in as an admin$/ do
	step 'I am on the login page'
	step 'I fill in "user_email" with "admin@admin.com"'
	step 'I fill in "user_password" with "admin"'
	step 'I press "Login"'
end

When /^I fill in the email body with "(.*)"$/ do |msg|
	step 'I fill in "body" with "' + msg + '"'
end

Then /^my card should be sent to the correct number of subscribers$/ do
	step 'I should see "Your newsletter has been sent to 3 subscribers!"'
end
