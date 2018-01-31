require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-681
RSpec.describe 'Validate gross monthly income test', type: :feature, js: true do
  # Personas
  #
  # JOHN is a single, 56 year old man with 1 child. He is not on any benefit. He has £2,990 worth of capital and an income of £1,330. He has a court fee of £600
  # JAMES is a single, 45 year old man with 0 children. He is not on income benefit. He has £4,999 worth of capital and an income of £1,084. He has a court fee of £1,664
  # SUE is a married, 75 year old woman with 0 children. She is not on any benefit. She has £9,999 worth of capital and an income of £0. He has a court fee of £4,000
  #
  #
  # Feature: Validate Total Income field
  # HwF Eligibility Calculator should be able to validate the total income field at the form level
  #
  # Scenario: Specify valid value in Total Income field (Revised)
  #             Given I am JOHN
  #             And I am on the total income page
  #             And I enter a valid amount in the field
  #             When I click on the Next step button
  #             Then the value in the field is validated
  #             And I should see total income response
  scenario 'Specify numeric value in Total Income field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.total_income.set('1000')
    total_income_page.next

    # Assert
    expect(full_remission_page).to be_displayed
  end

  # Scenario: Specify invalid value in Total Income field (Revised)
  #
  #             Given I am JAMES
  #             And I am on the total income page
  #             And I enter invalid input in the field
  #             When I click on the Next step button
  #             Then the value in the field is validated
  #             And I should see an error message
  #
  #       Error Message: "Please enter a valid value
  scenario 'Specify non-numeric value in Total Income field' do
    # Arrange
    given_i_am(:james)
    answer_up_to(:total_income)

    # Act
    total_income_page.total_income.set('£')
    total_income_page.next

    # Assert
    expect(total_income_page).to have_error_with_text(:non_numeric)
  end

  # Scenario: Validate empty Total Income field (Revised)
  #             Given I am JAMES
  #             And I am on the total income page
  #             And I leave total income field empty
  #             When I click on the Next step button
  #             Then I should see an error message
  #
  #       Error Message: "Please enter a valid value
  scenario 'Validate empty Total Income field' do
    # Arrange
    given_i_am(:james)
    answer_up_to(:total_income)

    # Act
    total_income_page.next

    # Assert
    expect(total_income_page).to have_error_with_text(:non_numeric)
  end
end
