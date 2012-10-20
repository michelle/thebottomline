Feature: Send an e-card to my loved ones
  As someone who wants to inform my loved ones about colorectal cancer
  So that I can quickly and simply remind my relatives to get screened
  I want to send e-cards to my relatives
  
  Scenario: Send an e-card without logging in
    Given I am not currently logged in
    When I am on the send an e-card page
    Then I should see "Send an e-card"
    And I fill in "Recipient" with "My Dad"
    And I fill in "Recipient's Email" with "mydad@bestdad.com"
    And I fill in "My Name" with "Michelle Bu"
    And I fill in "My Email" with "michelle@thebottomline.com"
    And I fill in "Message" with "Some nice message"
    # the blank e-card
    And I check "Blank"
    And I press "Send e-card"
    Then I should be on the e-card acknowledgement page
    Then I should see "Register Now"

  Scenario: Send an e-card when logged in
    Given I am logged in
    When I am on the send an e-card page
    Then I should see "Send an e-card"
    # We should use localStorage to store this for not logged in users too!
    Then the "My Name" field should contain "Michelle Bu"
    Then the "My Email" field should contain "michelle@thebottomline.com"
    And I fill in "Recipient" with "My Uncle"
    And I fill in "Recipient's Email" with "myuncle@bestuncle.com"
    And I fill in "Message" with "Some nicer message"
    And I check "Blank"
    And I press "Send e-card"
    Then I should be on the e-card acknolwedgement page
