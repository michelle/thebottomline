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
    Given I am logged in as Admin
    When I fill in the newsletter text field with "Welcome bottomline users!"
      And I press send
    Then I should be prompt to verify my password
    When I fill in password with "somethingsecure"
      And I press send
    Then I should be on the admin page
      And I should see "Your newsletter has been sent!"
      
  Scenario: Sending newsletters to subscribers with no content as an Admin
    Given I am logged in as Admin
    When I press "Send newsletter"
    Then I should be on the admin page
    And I should see "Silly, you forgot to send anything"
      
  Scenario: Downloading CSV file of all unsent postcards
    Given I am logged in as Admin
    When I press download postcards
    Then I should be on the admin page
    And I should see "Downloading"
      
  Scenario: Number of subscribed users
    Given I am logged in as Admin
    Then I should see the number of current subscribers is 3
  
  
  
  
  
  
  
  
  
  
