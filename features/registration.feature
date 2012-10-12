Feature: Registration
  As a user
  In order to use the Bottom Line more personally
  I want to be able to register securely

  Scenario: Standard registration
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Sign Up"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    # We should allow users who don't want to give up their address to also register, but then during the sending save their address/stuff.
    Then I should see the registration acknowledgment page
    Then I should see "Send a reminder today!"
