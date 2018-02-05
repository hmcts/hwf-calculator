require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-675
RSpec.describe 'Validate savings and investment test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::IncomeBenefitsPage.new }

  # Feature: Validate Savings & Investments field
  # Validate the Savings and Investments field at the form level
  #
  #
  # Scenario: Enter valid value in Savings & Investments field (Revised)
  #              Given I am on the savings and investments question
  #              And I enter valid value in the savings & investments field
  #              When I click on the Next step button
  #              Then the value in the field is validated
  #              And I should see the next question
  scenario 'Enter valid value in Savings & Investments field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:disposable_capital)

    # Act
    disposable_capital_page.disposable_capital.set('1000')
    disposable_capital_page.next

    # Assert
    expect(next_page).to be_displayed
  end
  # Scenario: Enter invalid value in Savings & Investments field (Revised)
  #            Given  I am on the savings and investments question
  #             And I enter invalid value in the savings & investments field
  #             When I click on the Next step button
  #            Then the value in the field is validated
  #            And I should see error message
  # Error Message: "Enter a valid value"
  scenario 'Enter invalid value in Savings & Investments field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:disposable_capital)

    # Act
    disposable_capital_page.disposable_capital.set('£')
    disposable_capital_page.next

    # Assert
    expect(disposable_capital_page.disposable_capital).to have_error_non_numeric
  end
  # Scenario: Savings & Investments field is empty/blank - no entry (Revised)
  #             Given  I am on the savings and investments question
  #             And I leave the field blank
  #             When I click on the Next step button
  #             Then the value in the field is validated
  #             And I should see error message
  #
  #     Error Message: "Enter how much you have in savings and investments"
  scenario 'Savings & Investments field is empty/blank - no entry' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:disposable_capital)

    # Act
    disposable_capital_page.next

    # Assert
    expect(disposable_capital_page.disposable_capital).to have_error_blank
  end
end
