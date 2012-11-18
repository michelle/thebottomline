Feature: Login as an Admin user
  
  As the founder of Bottom Line
  So that I can spread the word to users about colorectal 
    cancer and remind them to have their loved ones checked
  I want to send periodic newsletters and reminders.

  Background: Users have been added to database
    Given the following users exist:
    | name       | email                       | password        | subscribed | is_admin |
    | Stephanie  | user@usermail.com           | mypassword      | true       | false    |
    | Jeffrey    | poop@poopmail.com           | poopword        | nil        | false    |
    | Mr. Mitten | mits@usermail.com           | catsrule        | true       | false    |
    | Admin      | signthebottomline@gmail.com | somethingsecure | true       | true     |
    
  Scenario: Prevent non admin from accessing the admin page
    Given I am logged in as Stephanie
    When I go to the admin page
    Then I should be on the login page
    
  Scenario: Sending newsletters to subscribers via text box as an Admin
    Given I am an admin of The Bottom Line
    And I log in as an admin
    When I fill in "subject" with "Welcome Bottom Line Users!"
    When I fill in the email body with "Hello there!"
    When I fill in "confirm" with "admin"
      And I press "Send Newsletter"
    Then my card should be sent to the correct number of subscribers
      

  Scenario: Sending newsletters without the correct password
    Given I am an admin of The Bottom Line
    And I log in as an admin
    When I fill in "subject" with "Something Mean"
    And I fill in the email body with "Something really mean"
    And I fill in "confirm" with "evil"
    And I press "Send Newsletter"
    Then I should see "Password is incorrect"
