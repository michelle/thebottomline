Feature: Send an ecard to my loved ones
  As someone who wants to inform my loved ones about colorectal cancer
  So that I can quickly and simply remind my relatives to get screened
  I want to send e-cards to my relatives

  Background:
    Given I have registered with The Bottom Line
  
  Scenario: Send an ecard without logging in
    Given I am not logged in and trying to send an ecard
    And I fill in the ecard form
    And I press "Send my card!"
    Then my ecard should be sent

  Scenario: See previously sent ecards when logged in
    Given I am logged in and trying to send an ecard
    Given I have already sent ecards
    Then I should see previous ecards I have sent

  Scenario: Send any ecard while logged in 
    Given I am logged in and trying to send an ecard
    # user name, email
    Then my account information should be already filled in
    # either manually or by clicking
    And I fill in the ecard form
    And I press "Send my card!"
    Then my ecard should be sent

