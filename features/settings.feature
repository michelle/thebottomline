Feature: Change my settings
  As a registered user of The Bottom Line
  In order to change the information stored on the site
  I want to be able to change my settings

  Background: 
    Given I have registered with The Bottom Line
    And I have logged in
    And I am on the settings page

  Scenario: Changing my password
    Given I enter my password correctly
    And I fill in my new password and confirmation
    And I press "Update Settings"
    Then I should see a success message on the settings page
    And I should be on the settings page

  Scenario: Changing my name
    Given I enter my password correctly
    And I fill in "user_name" with "Poop"
    And I press "Update Settings"
    Then I should see a success message on the settings page
    And I should see that my name is "Poop"

  Scenario: Subscribing to the newsletter
    Given I enter my password correctly
    And I check "user_subscribed"
    And I press "Update Settings"
    Then I should see a success message on the settings page
    And the "user_subscribed" checkbox should be checked

  Scenario: Unsubscribing to the newsletter
    Given I enter my password correctly
    And I uncheck "user_subscribed"
    And I press "Update Settings"
    Then I should see a success message on the settings page
    And the "user_subscribed" checkbox should not be checked

  Scenario: Entering an incorrect original password 
    Given I enter my password incorrectly
    And I press "Update Settings"
    Then I should see a failure message on the settings page

  Scenario: Entering an invalid new password 
    Given I enter my password correctly
    And I fill in "user_password" with "pee"
    And I fill in "confirm" with "pee"
    And I press "Update Settings"
    Then I should see a failure message on the settings page

  Scenario: Entering new passwords that don't match 
    Given I enter my password correctly
    And I fill in "user_password" with "poop"
    And I fill in "confirm" with "poopagain"
    And I press "Update Settings"
    Then I should see a failure message on the settings page
