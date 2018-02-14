require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-659
RSpec.describe 'Disposable capital test', type: :feature, js: true do
  # Feature: Disposable Capital Test
  # HwF eligibility Calculator will execute disposable capital test to check citizen eligibility
  # Eligibility criteria for disposable capital test is specified in the legislation and threshold summary for fee exemption and fee remission outlined in the HwF Eligibility Calculator requirements page in confluence
  # Rules:
  # When citizen (or their partner) are 61 or over, they may have up to £16,000 in savings and investments
  # When citizen (and their partner) are under 61, the maximum amount of savings and investments allowed is specified in the (see Requirements Page)
  # If citizen is part of a couple and sharing an income, then their partner’s financial situation will be taken into consideration and citizen must give details of their savings and income
  # Citizen must confirm their partner status, enter their court or tribunal fee, age (and partner's age), savings and investments amount into the calculator to test for disposable capital
  #
  # Personas
  # JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  # ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  # OLIVER is a married, 75 year old man with £15,000 worth of capital. He has a court fee of £20,000
  # LOLA is a married, 90 year old woman with £19,000 worth of capital. She has a court fee of £100,000
  # BABA is a single, 40 year old man with £15,000 worth of capital. He has a court fee of £6,500
  # TONY is a married, 59 year old man with £18,000 worth of capital. He has a court fee of £7,500
  # DAVID is single, 62 year old man with £25,000 worth of capital. He has a court fee of £50,000
  # TOM is single, 80 year old man with £15,999 worth of capital. He has a court fee of £100
  # SUE is a married, 75 year old woman with £9,999 worth of capital. He has a court fee of £4,000
  #
  # Messaging
  # Positive
  # You may be able to get help with fees
  # Positive decision: With a fee of £XXX and savings of £XXX you are likely to get help with your fees, as long as you receive certain benefits or are on a low income. We will now look at these on the next pages (Revised)
  # Negative
  # You are unlikely to get help with your fees
  # With a fee of £XXX and savings of £XXX, it is unlikely that you'll be able to get financial help,  unless you are likely to experience exceptional hardship
  #
  # NOTES FOR DEVS
  #  Make exceptional hardship a link to Page 16 of EX160a OR an extract of the section. I have attached EX160A to ticket
  #
  #
  # Scenario: Under 61 and single pass disposable capital test
  #         Given I am JOHN
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am able to get help with fees
  scenario 'Under 61 and single pass disposable capital test' do
    # Arrange
    given_i_am :john
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.positive")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.positive",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end

  #
  # Scenario: Under 61 and married pass disposable capital test
  #         Given I am ALLI
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am able to get help with fees
  #
  scenario 'Under 61 and married pass disposable capital test' do
    # Arrange
    given_i_am :alli
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.positive")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.positive",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Over 61 and married pass disposable capital test
  #         Given I am OLIVER
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am able to get help with fees
  #
  scenario 'Over 61 and married pass disposable capital test' do
    # Arrange
    given_i_am :oliver
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.positive")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.positive",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Over 61 and married fail disposable capital test
  #         Given I am LOLA
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am unlikely to get help with fees
  #
  scenario 'Over 61 and married fail disposable capital test' do
    # Arrange
    given_i_am :lola
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.negative")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.negative",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Under 61 and single fail disposable capital test
  #         Given I am BABA
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #          Then I should see that I am unlikely to get help with fees
  #
  scenario 'Under 61 and single fail disposable capital test' do
    # Arrange
    given_i_am :baba
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.negative")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.negative",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Under 61 and married fail disposable capital test
  #         Given I am TONY
  #          And I am on the savings and investment page
  #          And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am unlikely to get help with fees
  #
  scenario 'Under 61 and married fail disposable capital test' do
    # Arrange
    given_i_am :tony
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.negative")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.negative",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Over 61 and single fail disposable capital test
  #         Given I am DAVID
  #         And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am unlikely to get help with fees
  #
  scenario 'Over 61 and single fail disposable capital test' do
    # Arrange
    given_i_am :david
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.negative")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.negative",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
  # Scenario: Over 61 and single pass disposable capital test
  #         Given I am TOM
  #          And I am on the savings and investment page
  #         And I fill in the savings and investment page
  #         When I click on the Next step button
  #         Then I should see that I am able to get help with fees
  scenario 'Over 61 and single pass disposable capital test' do
    # Arrange
    given_i_am :tom
    answer_up_to(:disposable_capital)
    marital_status = user.marital_status

    # Act
    answer_disposable_capital_question

    # Assert
    aggregate_failures 'validating feedback' do
      expect(any_calculator_page).to have_feedback_message_with_header(:"disposable_capital.#{marital_status}.positive")
      expect(any_calculator_page).to have_feedback_message_with_detail :"disposable_capital.#{marital_status}.positive",
        fee: user.fee,
        disposable_capital: user.disposable_capital
    end
  end
end
