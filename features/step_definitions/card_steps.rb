Given /^I am not logged in and trying to send an ecard$/ do
	step 'I am trying to send an ecard'
	step 'I should see "Sign in"'
end

Given /^I am logged in and trying to send an ecard$/ do
	step 'I have logged in'
	step 'I am trying to send an ecard'
end


Given /^I fill in the ecard form$/ do
	step 'I fill in "card_sender" with "Michelle"'
	step 'I fill in "email" with "michellebu@berkeley.edu"'
	step 'I fill in "card_recipient" with "My Dad"'
	step 'I fill in "card_address" with "bestdad@mydad.com"'
	step 'I fill in "card_message" with "Hi dad please get checked"'
end

Then /^my ecard should be sent$/ do
	step 'I should see "Your E-card has been sent"'
end

Given /^I am trying to send an ecard$/ do
	step 'I am on the send ecard page'
end

When /^I fill in the ecard form without a valid recipient$/ do
	step 'I fill in the ecard form'
	step 'I fill in "card_address" with "invalid"'
end


When /^I fill in the ecard form without my information$/ do
	step 'I fill in the ecard form'
	step 'I fill in "card_sender" with ""'
end

Then /^I should see previous ecards I have sent$/ do
	step 'I should see "Use a recently sent card"'
end

Then /^my account information should be already filled in$/ do
	step 'the "Name" field should contain "' + @user.name.split[0] + '"'
	step 'the "Email" field should contain "' + @user.email + '"'
end

Given /^I have already sent ecards$/ do
	step 'I fill in the ecard form'
	step 'I press "Send my card!"'
	step 'I am trying to send an ecard'
end
