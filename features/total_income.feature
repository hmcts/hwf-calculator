@e2e
@javascript

Feature: Total income page

Scenario: Successfully submits my total income
  Given I am Claude and partner
  And I am on the total income page
  When I successfully submit our total income
  Then on the next page our total income has been added to previous answers

Scenario: Eligible for full remission
  Given I am John
  And I am on the total income page
  When I successfully submit my total income
  Then I should see that I should be eligible for full remission

Scenario: Eligible for part remission
  Given I am Eden
  And I am on the total income page
  When I successfully submit my total income
  Then I should see that I should be eligible for part remission

Scenario: Not eligible for remission
  Given I am Joseph
  And I am on the total income page
  When I successfully submit my total income
  Then I should see that I am not eligible for remission

Scenario: What to include as income
  Given I am Joseph
  And I am on the total income page
  When I click on what to include as income
  Then I should see the copy for what to include as income

Scenario: Displays total income error message
  Given I am Joseph
  And I am on the total income page
  When I click next without submitting my total income
  Then I should see the total income error message

Scenario: Changing answer updates eligibility
  Given I am Thomas
  And I am on the total income page
  When I change my answer for my court and tribunal fee to £1000
  Then I should see that I am now unlikely to get help with fees
  And I should see my answer for court and tribunal fee has been changed
