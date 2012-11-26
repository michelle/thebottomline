Feature: Donations 
  As the founder of The Bottom Line
  In order to keep running a nonprofit initiative
  I want to be able to accept donations

  Scenario: Be asked to donate to The Bottom Line after sending an ecard
    Given I have sent a ecard
    Then I should be prompted to donate to The Bottom Line
  
  Scenario: Be asked to donate to The Bottom Line after sending a postcard 
    Given I have sent a postcard
    Then I should be prompted to donate to The Bottom Line

  Scenario: Donate to The Bottom Line 
    Given I am on the donation page
    And I try to donate 
    Then I should be redirected to PayPal
    And I should see "Thanks for your donation"
