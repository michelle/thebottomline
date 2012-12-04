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

Then /^my postcard should be sent$/ do
	step 'I should see "Your postcard has been sent"'
end

Given /^I am trying to send an ecard$/ do
	step 'I am on the send ecard page'
end

Given /^I am trying to send a postcard$/ do
	step 'I am on the send postcard page'
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

Then /^I should see previous postcards I have sent$/ do
	step 'I should see "Use a recently sent card"'
end

Then /^my account information should be already filled in$/ do
	step 'the "card_sender" field should contain "' + @user.name.split[0] + '"'
	step 'the "email" field should contain "' + @user.email + '"'
end

Given /^I have already sent ecards$/ do
	step 'I fill in the ecard form'
	step 'I press "Send my card!"'
	step 'I am trying to send an ecard'
end

Given /^I have already sent postcards$/ do
	step 'I fill in the postcard form'
	step 'I press "Send my card!"'
	step 'I am trying to send a postcard'
end

Given /^I fill in the postcard form$/ do
	step 'I fill in "card_sender" with "Michelle"'
	step 'I fill in "card_recipient" with "My Dad"'
	step 'I fill in "card_address_street" with "123 Sesame St"'
	step 'I fill in "card_address_city" with "Berkeley"'
	step 'I fill in "card_address_state" with "CA"'
	step 'I fill in "card_address_zip" with "94709"'
	step 'I fill in "card_message" with "Hi dad please get checked"'
end

Given /^I choose a background option$/ do
	find(:xpath, '//img[@data-index="1"]').click
end

Then /^my ecard should have the selected background$/ do
	find(:xpath, "//input[@id='card_background']")['value'].should == '/images/backgrounds/1.png'
end

Then /^my ecard should have the default background$/ do
	find(:xpath, "//input[@id='card_background']")['value'].should == '/images/backgrounds/default.png'
end

Then /^my postcard should have the default background$/ do
	find(:xpath, "//input[@id='card_background']")['value'].should == '/images/backgrounds/default.png'
end

Given /^I am logged in and trying to send a postcard$/ do
	step 'I have logged in'
	step 'I am trying to send a postcard'
end

Then /^my postcard should have the selected background$/ do
	find(:xpath, "//input[@id='card_background']")['value'].should == '/images/backgrounds/1.png'
end

Given /^I choose a preset message$/ do
	find(:xpath, "//div[@class='message'][last()]").click
end

Then /^my ecard should have the selected message$/ do
	find(:xpath, "//textarea[@id='card_message']")['value'].should == 'Prevention is the best cure.'
end

Then /^my postcard should have the selected message$/ do
	find(:xpath, "//textarea[@id='card_message']")['value'].should == 'Prevention is the best cure.' 
end

Then /^the preview should show my chosen message$/ do
	find(:xpath, "//div[@class='cardpreview-caption']").should have_content('Prevention is the best cure')
end
