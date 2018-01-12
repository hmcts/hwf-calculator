require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-675
RSpec.describe 'Validate savings and investment test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::NumberOfChildrenPage.new }

  # Feature: Validate Savings & Investments field
  # Validate the Savings and Investments field at the form level
  #
  # @TODO Implement the scenario below as part of RST-744 then remove this comment
  # Scenario: Savings & Investments field tool tip
  #              Given user navigate to the savings and investments question
  #              And focus is away from the savings and investments field
  #              When user view the savings and investments field
  #              Then user should see tooltip displayed in the field
  #      Tooltip content: "£ Enter valid value with no decimal places"
  #
  #
  # Scenario: Enter valid value in Savings & Investments field
  #              Given user navigate to the savings and investments question
  #              And click in the savings & investments field
  #              When user enter valid value in the field
  #              And click on the Next step button
  #              Then the value in the field is validated
  #              And user should see disposable capital response
  #      Default value on field selection: "£"
  scenario 'Enter valid value in Savings & Investments field' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_disposable_capital

    # Act
    disposable_capital_page.disposable_capital.set('1000')
    disposable_capital_page.next

    # Assert
    expect(next_page).to be_present
  end
  # Scenario: Enter invalid value in Savings & Investments field
  #              Given user navigate to the savings and investments question
  #              And click in the savings & investments field
  #              When user enter invalid value in the field
  #              And click on the Next step button
  #              Then the value in the field is validated
  #              And user should see error message
  #       Error Message: "Please enter a valid value. The two nearest valid values are: XX and XX."
  scenario 'Enter invalid value in Savings & Investments field' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_disposable_capital

    # Act
    disposable_capital_page.disposable_capital.set('£')
    disposable_capital_page.next

    # Assert
    expect(disposable_capital_page.error_with_text(messaging.t('hwf_pages.disposable_capital.errors.non_numeric'))).to be_present
  end
  # Scenario: Savings & Investments field is empty/blank - no entry
  #              Given user navigate to the savings and investments question
  #              And click in the savings & investments field
  #              When user leave Savings & Investments field blank
  #              And click on the Next step button
  #              Then user should see error message
  #       Error Message: "Enter how much you have in savings and investments"
  scenario 'Savings & Investments field is empty/blank - no entry' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_disposable_capital

    # Act
    disposable_capital_page.next

    # Assert
    expect(disposable_capital_page.error_with_text(messaging.t('hwf_pages.disposable_capital.errors.blank'))).to be_present
  end
end
