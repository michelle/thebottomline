Feature: 404 message 
  As the founder of The Bottom Line
  In order to constructively let users know when they've accessed an invalid page
  I want to have a custom 404 page

  Scenario: Accessing an invalid page 
    When I access an invalid page
    Then I should be on the 404 page
