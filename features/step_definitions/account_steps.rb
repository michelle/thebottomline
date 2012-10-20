Given /^I am not currently logged in$/ do
	step 'I should not see "Sign out"'
end

Given /^I am logged in$/ do
	step 'I should not see "Sign in"'
end

Given /^"(.*?)" is an existing email$/ do |arg1|
	User.create!({ :name => 'Tester',
							   :email => arg1,
								 :password => 'hunter2' })
end

Given /^I have registered with The Bottom Line$/ do
	User.create!({ :name => 'Michelle',
							   :email => 'michellebu@berkeley.edu',
							   :password => 'hunter2' })
end

Given /^I have logged in$/ do
	step 'I am on the login page'
	step 'I fill in "user_email" with "michellebu@berkeley.edu"'
	step 'I fill in "user_password" with "hunter2"'
	step 'I press "Login"'
end
