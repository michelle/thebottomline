Feature: Customize cards with backgrounds and messages
  As a user
  In order to send fun and personal cards
  I would like to customize my cards with backgrounds and messages

  Background:
    Given I have registered with The Bottom Line	

  Scenario: Apply a background to my e-card
    Given I am trying to send an ecard
    And I choose a background option
    And I fill in the ecard form
    And I press "Send my card!"
    Then my ecard should be sent with the background I chose

  Scenario: Apply a background to my postcard
    Given I am logged in and trying to send a postcard
    And I choose a background option
    And I fill in the ecard form
    And I press "Send my card!"
    Then my postcard should be sent with the background I chose

  Scenario: Apply a message to my postcard
    Given I am logged in and trying to send a postcard
    And I fill in the postcard form
    And I choose a preset message
    And I press "Send my card!"
    Then my postcard should be sent with the message I chose

  Scenario: Apply a message to my e-card
    Given I am trying to send an ecard
    And I fill in the ecard form
    And I choose a preset message
    And I press "Send my card!"
    Then my ecard should be sent with the message I chose

  Scenario: Apply a message and enter my own message for my e-card
    Given I am trying to send an ecard
    And I fill in the ecard form
    And I choose a preset message
    And I type more into the message
    And I press "Send my card!"
    Then my ecard should be sent with the message I chose and my own message

  Scenario: Apply a message and enter my own message for my postcard
    Given I am trying to send an postcard
    And I fill in the postcard form
    And I choose a preset message
    And I type more into the message
    And I press "Send my card!"
    Then my postcard should be sent with the message I chose and my own message
