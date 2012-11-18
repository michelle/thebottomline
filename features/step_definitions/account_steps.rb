Given /^I am not currently logged in$/ do
	step 'I should not see "Logout"'
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
							   :password => 'hunter2'})
	@user = User.new
	@user.name = 'Michelle'
	@user.email = 'michellebu@berkeley.edu'
	@user.password = 'hunter2'
end

Given /^I am an admin of The Bottom Line$/ do
	User.create!({ :name => 'Michelle',
							   :email => 'admin@admin.com',
							   :password => 'admin' ,
                 :is_admin => true})
	@user = User.new
	@user.name = 'Michelle'
	@user.email = 'admin@admin.com'
	@user.password = 'admin'
  @user.is_admin = true
end

Given /^I have logged in$/ do
	step 'I am on the login page'
	step 'I fill in "user_email" with "michellebu@berkeley.edu"'
	step 'I fill in "user_password" with "hunter2"'
	step 'I press "Login"'
end

When /^I try to recover my password$/ do
	step 'I am on the recover password page'
  step 'I fill in "email" with "michellebu@berkeley.edu"'
  step 'I press "Send New Password"'
end
