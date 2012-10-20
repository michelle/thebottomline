Feature: Recovering a lost password
  As a user who is forgetful
  In order to regain access to my account
  I want to be able to recover my lost password

  Scenario: Resetting the password associated with an email
    Given I have registered with The Bottom Line
    When I try to recover my password
    Then I should be on the welcome page
    And I should see "Password successfully sent"

  Scenario: Resetting the password of an unknown email
    When I try to recover my password
    Then I should be on the recover password page
    And I should see "Email not found"

