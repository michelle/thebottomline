Feature: Login and logout
  As a user
  In order to access my information on different devices
  I want to be able to log in and out easily

  Background:
    Given I have registered with The Bottom Line

  Scenario: Logging in
    Given I am not currently logged in
    When I am on the login page
    Then I should see "Login"
    And I fill in "user_email" with "michellebu@berkeley.edu"
    And I fill in "user_password" with "hunter2"
    And I press "Login"
    Then I should be on the send a reminder page 
    Then I should see "Welcome, Michelle!"
    Then I am logged in

  Scenario: Logging out
    Given I have logged in
    When I follow "Logout"
    Then I should see "Logged out successfully"
    Then I am not currently logged in

  Scenario: Logging in with bad credentials
    Given I am not currently logged in
    When I am on the login page
    And I fill in "user_email" with "michellebu@berkeley.edu"
    And I fill in "user_password" with "evilpassword"
    And I press "Login"
    Then I should be on the login page
    Then I should see "Email and password combination do not match"
