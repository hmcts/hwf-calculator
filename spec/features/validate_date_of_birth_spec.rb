require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-728
RSpec.describe 'Validate date of birth Test', type: :feature, js: true do
  # Feature: Date of Birth field validation
  # HwF eligibility Calculator should validate input in the date of birth field
  #
  # Rules:
  # When user select Single option in question 1, only one set of DoB field should surface for user entry
  # When user select Married or living with someone option in question 1, two sets of DoB field should surface for user entry
  # For single citizen under 16 years old, at validation error message should be displayed and calculator session terminated (PO to sign-off)
  # For single citizen under 61 years old, at validation output should be used for disposable capital test
  # For single citizen over 61 years old, at validation output should be used for disposable capital test
  # For married citizen where both citizen and partner are under 61, at validation output should be classified as under 61 years old and used for disposable capital test
  # For married citizen where both citizen and partner are over 61, at validation output should be classified as over 61 years old and used for disposable capital test
  # For married citizen where either of them is under 61, at validation output should be classified as under 61 years old and used for disposable capital test (PO to sign-off)
  # For married citizen where either of them is under 16, at validation error message should be displayed and calculator session terminated (PO to sign-off)
  #
  # Personas
  # ALAN is a single, 15 year old boy
  # JOHN is a single, 56 year old man
  # CALVIN is a single, 70 year old man
  # ALLI is a married, 60 year old man with partner who is 50 year old
  # OLIVER is a married, 75 year old man with partner who is 70 year old
  # CLAUDE is a married, 60 year old man with partner who is 75 year old
  # VERONICA is a married, 15 year old girl with partner who is 25 year old
  #
  # Scenario: Citizen leave DoB field blank
  #               Given I am JOHN
  #                And I am on the date of birth page
  #               And I leave date of birth field blank
  #               When I click on the Next step button
  #               Then I should see an error message
  #  #Error Message: Please enter a valid date of birth
  #
  # Scenario: Single citizen who is under 16 years old enter their date of birth
  #               Given I am ALAN
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see an error message
  #  #Error Message: You must be over 16 years old to apply for help with fees
  #
  # Scenario: Under 61 single citizen enter date of birth
  #               Given I am JOHN
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  # Scenario: Over 61 single citizen enter date of birth
  #               Given I am Calvin
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  # Scenario: Under 61 citizen and partner enter date of birth
  #               Given I am ALLI
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #               And disposable capital test should classify applicant as under 61
  #
  # Scenario: Over 61 citizen and partner enter date of birth
  #               Given I am OLIVER
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #               And disposable capital test should classify applicant as over 61
  #
  # Scenario: Citizen is under 61 and partner is over 61
  #               Given I am CLAUDE
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #               And disposable capital test should classify applicant as under 61
  #
  # Scenario: Citizen is under 16 and partner is under 61
  #               Given I am VERONICA
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see an error message
  #
  #     #Error Message: You and your partner must be over 16 years old to apply for help with fees
end