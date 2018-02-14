@e2e
@javascript

Feature: Landing page

Background: Income benefits page
  Given I am on the landing page

Scenario: Displays copy
  Then I should see information about the help with fees calculator

Scenario: Start now
  When I click on start now
  Then I am taken to the next page
