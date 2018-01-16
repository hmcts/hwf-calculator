@e2e
@javascript

Feature: Date of birth

Scenario: Successfully submit my date of birth
  Given I am David
  And I am on the date of birth page
  When I sucessfully submit my date of birth
  Then on the next page I should see my previous answer with my date of birth

Scenario: Successfully submit my partners date of birth
  Given I am Tony and partner
  And I am on the date of birth page
  When I sucessfully submit our date of births
  Then on the next page I should see my previous answer with our date of births

Scenario: Displays date of birth error message
  Given I am David
  And I am on the date of birth page
  When I click next without submitting my date of birth
  Then I should see the date of birth error message
