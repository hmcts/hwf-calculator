require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-728
# The welsh version is RST-818
RSpec.describe 'Validate date of birth Test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::DisposableCapitalPage.new }

  # Feature: Date of Birth field validation
  # HwF eligibility Calculator should validate input in the date of birth field
  #
  # Rules:
  # When user select Single option in question 1, only one set of DoB field should surface for user entry
  # When user select Married or living with someone option in question 1, two sets of DoB field should surface for user entry
  # For single citizen under 15 years old, at validation error message should be displayed and calculator session terminated (Revised - Citizen must be over 15)
  # For single citizen under 61 years old, at validation output should be used for disposable capital test
  # For single citizen over 61 years old, at validation output should be used for disposable capital test
  # For married citizen where both citizen and partner are under 61, at validation output should be classified as under 61 years old and used for disposable capital test
  # For married citizen where both citizen and partner are over 61, at validation output should be classified as over 61 years old and used for disposable capital test
  # For married citizen where either of them is under 61, at validation output should be classified as under 61 years old and used for disposable capital test
  # For married citizen where either of them is under 15, at validation error message should be displayed and calculator session terminated (Revised - Citizen must be over 15)
  #
  # Personas
  #
  # ALAN is a single, 14 year old boy
  # JOHN is a single, 56 year old man
  # CALVIN is a single, 70 year old man
  # ALLI is a married, 60 year old man with partner who is 50 year old
  # OLIVER is a married, 75 year old man with partner who is 70 year old
  # CLAUDE is a married, 60 year old man with partner who is 75 year old
  # VERONICA is a married, 15 year old girl with partner who is 25 year old
  # SUE is a married, 75 year old woman with partner who is 73 years old
  # OLA is a married, 14 year old woman with partner who is 40 years old
  #
  # Error Message (under age): You and your partner must be over 15 to apply for help with fees (Revised)
  #
  # Scenario: Citizen leave DoB field blank
  #               Given I am JOHN
  #                And I am on the date of birth page
  #               And I leave date of birth field blank
  #               When I click on the Next step button
  #               Then I should see an error message
  #
  #  Error Message: Enter the date in this format DD/MM/YYYY (Revised)
  scenario 'Citizen leave DoB field blank' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end
  #
  # Scenario: Single citizen who is under 15 years old enter their date of birth (Revised)
  #               Given I am ALAN
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see an error message
  #
  #  Error Message: You must be over 15 to apply for help with fees (Revised)
  scenario 'Single citizen who is under 16 years old enter their date of birth' do
    # Arrange
    given_i_am(:alan)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_under_age
  end
  # Scenario: Under 61 single citizen enter date of birth
  #               Given I am JOHN
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  scenario 'Under 61 single citizen enter date of birth' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end
  #
  # Scenario: Over 61 single citizen enter date of birth
  #               Given I am Calvin
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  scenario 'Over 61 single citizen enter date of birth' do
    # Arrange
    given_i_am(:calvin)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end

  # Scenario:* Over 61 single citizen enter invalid input
  # Given I am CALVIN
  # And I am on the date of birth page
  # And I fill in my date of birth field with invalid input
  # When I click on the Next step button
  # Then I should see an error message
  #
  # *Error Message:* Enter the date in this format DD/MM/YYYY
  scenario 'Over 61 single citizen enter invalid input' do
    # Arrange
    given_i_am(:calvin)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('01/July/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric

  end

  scenario 'Citizen enters 2 digit year' do
    # Arrange
    given_i_am(:calvin)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('1/7/70')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end
  # Scenario: Under 61 citizen and partner enter date of birth
  #               Given I am ALLI
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  scenario 'Under 61 citizen and partner enter date of birth' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end

  # Scenario: Over 61 citizen and partner enter date of birth
  #               Given I am OLIVER
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  scenario 'Over 61 citizen and partner enter date of birth' do
    # Arrange
    given_i_am(:oliver)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end
  # Scenario: Citizen is under 61 and partner is over 61
  #               Given I am CLAUDE
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  #
  scenario 'Citizen is under 61 and partner is over 61' do
    # Arrange
    given_i_am(:claude)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end
  # *Scenario:* Citizen is over 15 and partner is 25
  #                Given I am VERONICA
  #                And I am on the date of birth page
  #                And I fill in my date of birth
  #                And I fill in my partner date of birth
  #                When I click on the Next step button
  #                Then I should see  the next page
  scenario 'Citizen is over 15 and partner is 25' do
    # Arrange
    given_i_am(:veronica)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end

  # Scenario:* Citizen is over 61 and partner is 73
  #                Given I am SUE
  #                And I am on the date of birth page
  #                And I fill in my date of birth
  #                And I fill in my partner date of birth
  #                When I click on the Next step button
  #                Then I should see  the next page
  #
  scenario 'Citizen is over 61 and partner is 73' do
    # Arrange
    given_i_am(:sue)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end

  # *Scenario:* Citizen is 14 and partner is 40
  #                Given I am OLA
  #                And I am on the date of birth page
  #                And I fill in my date of birth
  #                And I fill in my partner date of birth
  #                When I click on the Next step button
  #                Then I should see  an error message
  #
  #        *Error Message:* Your partner must be over 15 to apply for help with fees
  scenario 'Citizen is 14 and partner is 40' do
    # Arrange
    given_i_am(:ola)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_under_age
  end

  # The following scenarios had no acceptance criteria from the business - but are important still
  scenario 'Citizen is single and puts non numerics in the day field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('day/07/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is single and puts non numerics in the month field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('01/July/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is single and puts non numerics in the year field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('01/07/someyear')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their own day field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('aa/07/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their own month field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('09/July/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their own year field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.date_of_birth.set('09/08/someyear')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their partners day field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.partner_date_of_birth.set('aa/07/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.partner_date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their partners month field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.partner_date_of_birth.set('09/July/1970')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.partner_date_of_birth).to have_error_non_numeric
  end

  scenario 'Citizen is married and puts non numerics in their partners year field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    date_of_birth_page.partner_date_of_birth.set('09/08/someyear')
    date_of_birth_page.next

    # Assert
    expect(date_of_birth_page.partner_date_of_birth).to have_error_non_numeric
  end
end
