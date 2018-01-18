@e2e
@javascript

Feature: Number of children

Background: Number of children page
  Given I am on the of children page

Scenario: Successfully submits my number of children
  When I successfully submit my number of children
  Then on the next page I should see my previous answer with our number of children

Scenario: Children who might affect your claim
  When I click on children who might affect your claim
  Then I should see the copy for children who might affect your claim

Scenario: Displays number of children error message
  When I click next without submitting my number of children
  Then I should see the number of children error message