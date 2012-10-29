Feature: Subscribe to Newsletter
   As a user
   In order to receive updates concerning colorectal cancer
   I want to be able to subscribe to the bottom line newsletter

   Scenario: Subscribe during registration
    Given I am not currently logged in
    When I am on the registration page
    Then I should see "Register"
    And I fill in "Name" with "Michelle Bu"
    And I fill in "Email" with "michellebu@berkeley.edu"
    And I fill in "Password" with "hunter2"
    And I fill in "Confirm Password" with "hunter2"
    And I check "Keep me informed with monthly newsletters!"
    And I press "Register"
    Then I should see "Thanks for signing up! You're ready to send cards"
    Then I am logged in
         
