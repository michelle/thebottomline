Feature: Send a postcard to my loved ones
  As a user whose relatives are not technically savvy
  So that I can remind my relatives to get screened for colorectal cancer
  I want to be able to send physical postcards.

  Background: Users have been added to database
    Given the following users exist:
    | username | name    | email              | password   |
    | A_User   | Mr_User | user@usermail.user | mypassword |
    
  Scenario: Send a postcard without logging in
    Given I am on the home page
    When I press "send_postcard"
    Then I should be on the login page
      And I should see "Please register or sign in first to send a postcard"

  Scenario: Sending a postcard successfully
    Given I am logged in as A_User
      And I am on the Send Postcard page
    When I select a design
      And I press "next"
    Then I should be on the add a message page
    When I fill in "message" with "What's up your butt!?"
      And I press "next"
    Then I should be on the fill in address page
    When I fill in "name" with "Your Colon"
      And I fill in "address" with "2316 Haste St"
      And I fill in "city" with "Berkeley"
      And I select "CA" for "state"
      And I fill in "zipcode" with "94704"
      And I press "send_postcard"
    Then I should be on the home page
      And I should see "Your postcard has been sent! Colons everywhere thank you"
      And my postcard count should be 1

  Scenario: Send postcard without a design
    Given I am logged in as A_User
      And I am on the send postcard page
    When I press "next"
    Then I should be on the send postcard page
      And I should see "Please select a colonful design!"

  Scenario: Send postcard with an invalid address
    Given I am on the fill in address page
    When I press "send_postcard"
    Then I should be on the fill in address page
      And I should see "Please use a valid address!"