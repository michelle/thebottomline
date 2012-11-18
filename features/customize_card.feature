Feature: Customize cards with backgrounds and messages
  As a user
  In order to send fun and personal cards
  I would like to customize my cards with backgrounds and messages

  Background:
    Given I have registered with The Bottom Line	

  Scenario: Apply a background to my e-card
    Given I am trying to send an ecard
    And I choose a background option
    Then my ecard should have the selected background

  Scenario: Do not apply a background to my e-card
    Given I am trying to send an ecard
    Then my ecard should have the default background

  Scenario: Apply a background to my postcard
    Given I am logged in and trying to send a postcard
    And I choose a background option
    Then my postcard should have the selected background

  Scenario: Do not apply a background to my postcard
    Given I am logged in and trying to send a postcard 
    Then my postcard should have the default background

  Scenario: Apply a message to my postcard
    Given I am logged in and trying to send a postcard
    And I fill in the postcard form
    And I choose a preset message
    Then my ecard should have the selected message

  Scenario: Apply a message to my e-card
    Given I am trying to send an ecard
    And I fill in the ecard form
    And I choose a preset message
    Then my postcard should have the selected message
