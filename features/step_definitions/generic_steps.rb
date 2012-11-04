Given /^I enter my password correctly$/ do
	step 'I fill in "password" with "' + @user.password + '"'
end

Given /^I enter my password incorrectly$/ do
	step 'I fill in "password" with "' + @user.password + 'blahh"'
end

Given /^I fill in my new password and confirmation$/ do
	step 'I fill in "user_password" with "somethingvalid"'
	step 'I fill in "confirm" with "somethingvalid"'
end

Then /^I should see a success message on the settings page$/ do
	step 'I should see "User settings updated"'
	step 'I should be on the settings page'
end

Then /^I should see a failure message on the settings page$/ do
	step 'I should see "Error"'
	step 'I should be on the settings page'
end

Then /^I should see that my name is "(.*?)"$/ do |name|
	step 'I should see "' + name + '"'
end
