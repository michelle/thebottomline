Feature: Send an ecard to my loved ones
  As someone who wants to inform my loved ones about colorectal cancer
  So that I can quickly and simply remind my relatives to get screened
  I want to send e-cards to my relatives
  
  Scenario: Send an ecard without logging in
    Given I am not logged in and trying to send an ecard
    And I fill in the ecard form
    And I press "Send"
    Then my ecard should be sent
    And I should be asked if I want to register

  Scenario: See previously sent ecards when logged in
    Given I am logged in and trying to send an ecard
    And I have already sent ecards
    Then I should see previous ecards I have sent
    Then I click on a previously sent ecard
    Then the ecard form should contain the information from that card

  Scenario: Send any ecard while logged in 
    Given I am logged in and trying to send an ecard
    # user name, email
    Then my account information should be already filled in
    # either manually or by clicking
    And I fill in the ecard form
    And I press "Send"
    Then my ecard should be sent
    And my ecard should be saved

  Scenario: Send an ecard without a recipient
    Given I am trying to send an ecard
    And I fill in the ecard form without a valid recipient
    And I press "Send"
    Then I should see "Please enter a valid recipient name and email"

  Scenario: Send an ecard without my information
    Given I am trying to send an ecard
    And I fill in the ecard form without my information
    And I press "Send"
    Then I should see "Please enter your name and email"

