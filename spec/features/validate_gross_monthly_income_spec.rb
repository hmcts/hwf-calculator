require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-681
RSpec.describe 'Validate gross monthly income test', type: :feature, js: true do
  # Feature: Validate Total Income field
  # HwF Eligibility Calculator should be able to validate the total income field at the form level
  #
  # @TODO Implement the scenario below as part of RST-744 then remove this comment
  # Scenario: Total Income field tool tip
  #             Given user navigate to the Total Income question
  #             And focus is away from the total income field
  #             When user view the total income field
  #             Then tooltip is displayed in the field
  #      #Tooltip content: "£ Please enter a number between 0 and 100,000 (no decimal places)".
  #      #Proposed content: "£ Enter numeric value (no decimal places)"
  #
  # Scenario: Specify numeric value in Total Income field
  #             Given user navigate to the Total Income question
  #             And click in the total income field
  #             When user enter numeric value in the field
  #             And click on the Next step button
  #             Then the value in the field is validated
  #             And Total Income response displayed
  #      #Default value on field selection: "£"
  scenario 'Specify numeric value in Total Income field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.total_income.set('1000')
    total_income_page.next

    # Assert
    expect(total_income_page).not_to be_displayed
  end

  # Scenario: Specify non-numeric value in Total Income field
  #             Given user navigate to the Total Income question
  #             And click in the total income field
  #             When user enter non-numeric value in the field
  #             And click on the Next step button
  #             Then the value in the field is validated
  #             And error message is displayed prompting user to enter numeric value
  #       #Error Message: "Please enter numeric value with no decimal places"
  scenario 'Specify non-numeric value in Total Income field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.total_income.set('£')
    total_income_page.next

    # Assert
    expect(total_income_page.error_with_text(messaging.t('hwf_pages.total_income.errors.non_numeric'))).to be_present
  end

  # Scenario: Validate empty Total Income field
  #             Given user navigate to the total income question
  #             And click in the total income field
  #             When user leave total income field empty
  #             And click on the Next step button
  #             Then error message is displayed prompting user to enter numeric value
  #       #Error Message: "Please enter numeric value with no decimal places"
  scenario 'Validate empty Total Income field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.next

    # Assert
    expect(total_income_page.error_with_text(messaging.t('hwf_pages.total_income.errors.non_numeric'))).to be_present
  end
end
