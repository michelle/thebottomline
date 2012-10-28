Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /^I am logged in as A_User$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I select a design$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I select "(.*?)" for "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^my postcard count should be (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

