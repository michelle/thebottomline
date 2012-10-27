Feature: Send reminders
  As a avid Bottom Line user
  In order to reach all of my relatives
  I want to send both postcards and ecards as reminders

  Scenario: Select to send an ecard
    Given I am on the reminders page
    # in reality these should be images with the given ID
    And I press "ecard"
    Then I should be on the send ecard page

  Scenario: Select to send a postcard
    Given I am on the reminders page
    And I press "postcard"
    Then I should be on the send postcard page
