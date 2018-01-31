@e2e
@javascript

Feature: Date of birth page

Scenario: Successfully submit my date of birth
  Given I am David
  And I am on the date of birth page
  When I successfully submit my date of birth
  Then on the next page my date of birth has been added to previous answers

Scenario: Successfully submit my partners date of birth
  Given I am Tony and partner
  And I am on the date of birth page
  When I successfully submit our date of births
  Then on the next page our date of births have been added to previous answers

Scenario: Displays date of birth error message
  Given I am Tony and partner
  And I am on the date of birth page
  When I click next without submitting our date of birth
  Then I should see the date of birth error messages
