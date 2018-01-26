@e2e
@javascript

Feature: Court and tribunal fee

Background: Court and tribunal fee page
  Given I am on the court and tribunal fee page

Scenario: Successfully submits court and tribunal fee
  When I successfully submit my court and tribunal fee
  Then on the next page my court and tribunal fee has been added to previous answers

Scenario: If you have already paid your court or tribunal fee
  When I click on if you have already paid your court or tribunal fee
  Then I should see the copy for if you have already paid your court or tribunal fee
  
Scenario: Displays court and tribunal fee error message
  When I click next without submitting my court and tribunal fee
  Then I should see the court and tribunal fee error message
