Feature: Registration
  As a user
  In order to use the Bottom Line more personally
  I want to be able to register securely

  Scenario: Standard registration
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    # We should allow users who don't want to give up their address to also register, but then during the sending save their address/stuff.
    Then I should see "Thanks for signing up! You're ready to send cards"
    Then I am logged in

  Scenario: Email already exists
    Given I am not currently logged in
    Given "takenemail@taken.com" is an existing email
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "takenemail@taken.com"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I press "Register"
    Then I should be on the registration page
    #Then the "Email" field should have the error "Email already exists"
    Then I should see "Email has already been taken"

  Scenario: Passwords do not match 
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter3"
    And I press "Register"
    Then I should be on the registration page
    #Then the "Password" field should have the error "Passwords don't match"
    Then I should see "Passwords do not match"

  Scenario: Password is too short
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hun"
    And I fill in "Confirm Password" with "hun"
    And I press "Register"
    Then I should be on the registration page
    #Then the "Password" field should have the error "Passwords don't match"
    Then I should see "Password is too short (minimum is 4 characters)"

  Scenario: Blank fields 
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter3"
    And I press "Register"
    Then I should be on the registration page
    #Then the "Name" field should have the error "Please fill required fields"
    Then I should see "Name can't be blank"
