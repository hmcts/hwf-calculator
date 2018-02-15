@e2e
@javascript

Feature: Income benefits page

Background: Income benefits page
  Given I am John
  And I am on the income benefits page

Scenario: Displays message
  Then I should see that I should be able to get help with fees message

Scenario: Displays income benefits list
  Then I should see income benefits list

Scenario: Displays none of the above guidance information
  When I select none of the above
  Then I should see the none of the above guidance information

Scenario: Displays dont know guidance information
  When I select dont know
  Then I should see the dont know guidance information

Scenario: Displays savings and investment error message
  When I click next without submitting my income benefits
  Then I should see the income benefits error message

Scenario: Select income related benefit option
  When I submit the page with income related benefit checked
  Then I should see that I should be eligible for a full remission

Scenario: Previous answers
  When I submit the page with income support
  Then on the next page my income benefit has been added to previous answers

Scenario: How benefits affect your claim
  When I click on how benefits affect your claim
  Then I should see the copy for how benefits affect your claim
