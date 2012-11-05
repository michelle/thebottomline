Feature: Send a postcard to my loved ones
  As a user whose relatives are not technically savvy
  So that I can remind my relatives to get screened for colorectal cancer
  I want to be able to send physical postcards.

  Background:
    Given I have registered with The Bottom Line

  Scenario: Send a postcard without logging in
    Given I am on the reminders page
    When I follow "Send a Postcard"
    Then I should be on the login page
    And I should see "You must be logged in to send postcards"

  Scenario: Sending a postcard successfully
    Given I have logged in
    And I am trying to send a postcard
    And I fill in the postcard form
    And I press "Send my card!"
    Then my postcard should be sent

  Scenario: See previously sent postcards when logged in
    Given I have logged in
    And I am trying to send a postcard
    And I have already sent postcards
    Then I should see previous postcards I have sent
