require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-674
RSpec.describe 'Highlighted Response', type: :feature, js: true do
  include ActiveSupport::NumberHelper
  include Calculator::Test::Pages
  let(:any_calculator_page) { Calculator::Test::BasePage.new }

  # Scenario: Under 61 years old view highlighted positive response
  #
  # Given I am JOHN
  #
  # And I am on the savings and investments page
  #
  # When I click on the Next step button
  #
  # Then I should see that I may get help with fees
  #
  # And response highlighted in blue

  scenario 'Under 61 years old view highlighted positive response - validating message header' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status.downcase

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'Validating message geader and details' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.positive")
      expect(any_calculator_page).to have_feedback_message_with_detail(:"disposable_capital.#{marital_status}.positive", fee: user.fee, disposable_capital: user.disposable_capital)
      expect(any_calculator_page.positive_message).to be_present
    end
  end
  #
  #
  #
  # Scenario: Over 61 year old view highlighted negative response
  #
  # Given I am LOLA
  #
  # And I am on the savings and investments page
  #
  # When I click on the Next step button
  #
  # Then I should see that I am unlikely to get help with fees
  #
  # And response highlighted in red
  scenario 'Under 61 years old view highlighted negative response - validating message header' do
    # Arrange
    given_i_am(:lola)
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status.downcase

    # Act
    answer_disposable_capital_question

    # Assert
    expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.negative")
  end

  scenario 'Under 61 years old view highlighted negative response - validating message details' do
    # Arrange
    given_i_am(:lola)
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status.downcase

    # Act
    answer_disposable_capital_question

    # Assert
    expect(any_calculator_page).to have_feedback_message_with_detail(:"disposable_capital.#{marital_status}.negative", fee: user.fee, disposable_capital: user.disposable_capital)

  end

  scenario 'Under 61 years old view highlighted negative response - validating message is positive' do
    # Arrange
    given_i_am(:lola)
    answer_up_to(:disposable_capital)

    # Act
    answer_disposable_capital_question

    # Assert
    expect(any_calculator_page.negative_message).to be_present
  end

end
