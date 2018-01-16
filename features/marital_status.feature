@e2e
@javascript

Feature: Marital status page

Scenario: Successfully submits single
  Given I am John
  And I am on the martial status page
  When I successfully submit my marital status as single
  Then on the next page I should see my previous answer single

Scenario: Successfully submits married
  Given I am Alli and partner
  And I am on the martial status page
  When I successfully submit my marital status as married
  Then on the next page I should see my previous answer married

Scenario: Help with status
  Given I am John
  And I am on the martial status page
  When I click on help with status
  Then I should see the copy for help with status

Scenario: Displays marital status error message
  Given I am John
  And I am on the martial status page
  When I click next without submitting my marital status
  Then I should see the marital status error message