Feature: Send reminders
  As a avid Bottom Line user
  In order to reach all of my relatives
  I want to send both postcards and ecards as reminders

  Scenario: Select to send an ecard
    Given I am on the reminders page
    # in reality these should be images with the given ID
    And I follow "Send an E-card"
    Then I should be on the send ecard page

  Scenario: Select to send a postcard without logging in
    Given I am on the reminders page
    And I follow "Send a Postcard"
    Then I should be on the login page
    And I should see "You must be logged in to send postcards"

  Scenario: Select to send a postcard while logged in
    Given I have registered with The Bottom Line
    And I have logged in
    Given I am on the reminders page
    And I follow "Send a Postcard"
    Then I should be on the send postcard page
