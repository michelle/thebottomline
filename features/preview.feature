Feature: Preview an e-card before sending 
  As someone who wants to send e-cards 
  So that I know what I am sending to my relatives
  I want to be able to preview the e-cards I send

  Background:
    Given I have registered with The Bottom Line
  
  @javascript
  Scenario: Preview e-cards before sending 
    Given I am logged in and trying to send an ecard
    And I fill in the ecard form
    And I choose a preset message
    Then the preview should show my chosen message

  @javascript
  Scenario: Preview postcard before sending 
    Given I am logged in and trying to send a postcard
    And I fill in the postcard form
    And I choose a preset message
    Then the preview should show my chosen message
