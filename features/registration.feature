Feature: Registration
  As a user
  In order to use the Bottom Line more personally
  I want to be able to register securely

  Scenario: Standard registration
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Sign Up"
    And I fill in "Username" with "michellebu"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    # We should allow users who don't want to give up their address to also register, but then during the sending save their address/stuff.
    Then I should be on the registration acknowledgment page
    Then I should see "Send a reminder today!"

  Scenario: Username already exists
    Given I am not currently logged in
    Given "takenusername" is an existing user
    When I am on the registration page
    Then I should see "Sign Up"
    And I fill in "Username" with "takenusername"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    Then I should be on the registration page
    Then the "Username" field should have the error "Username already exists"

  Scenario: Email already exists
    Given I am not currently logged in
    Given "takenemail@taken.com" is an existing email
    When I am on the registration page
    Then I should see "Sign Up"
    And I fill in "Username" with "michellebu"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "takenemail@taken.com"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    Then I should be on the registration page
    Then the "Email" field should have the error "Email already exists"

  Scenario: Passwords do not match 
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Sign Up"
    And I fill in "Username" with "michellebu"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter3"
    And I press "Register"
    Then I should be on the registration page
    Then the "Password" field should have the error "Passwords don't match"
