require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-745
# @TODO This feature is not 100% as per AC at the moment as I am questioning the resetting of previous questions - just the last step in every scenario
RSpec.describe 'Change previous answers test', type: :feature, js: true do
  # Feature: Change Previous Answer
  #
  # Ability to Change Previous Answer of Choice in the calculator
  #
  #
  # Rules:
  #
  # User should be able to update previous answers at any point in the calculator session
  # When an answer to a question is updated, calculation should be revalidated and corresponding response displayed
  # When previous answer is updated, answers to subsequent questions should be purged from the Previous answer section and related question fields reset
  # Design Assumptions:
  #
  # User unable to make updates to previous answers when they fail disposable capital test (PO to confirm)
  # User unable to make updates to previous answers in the income test response page (PO to confirm)
  # Personas:
  #
  # JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  # ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  # LOLA is a married, 90 year old woman with £19,000 worth of capital. She has a court fee of £100,000
  # THERESA is a single, 47 year old woman with no children. She has £15,999 worth of capital and an income of £5,086. He has a court fee of £7,500
  # Scenario: Citizen update Partner status from court or tribunal fee page
  #               Given I am JOHN
  #               And I am on the court or tribunal fee page
  #               When I click on the Change link for the Status question
  #               Then I should see the Status question prepopulated with previous answer
  #               And the Previous answers section should disappear
  scenario 'Citizen update Partner status from court or tribunal fee page' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_court_fee

    # Act
    court_fee_page.go_back_to_question(:marital_status)

    # Assert
    expect(marital_status_page).to be_displayed
  end
  #
  # Scenario: Citizen update Partner status from Number of Children page
  #               Given I am JOHN
  #               And I am on the Number of Children page
  #               When I click on the Change link for the Status question
  #               Then I should see the Status question prepopulated with previous answer
  #               And the Previous answers section should disappear
  #
  scenario 'Citizen update Partner status from Number of Children page' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_number_of_children

    # Act
    number_of_children_page.go_back_to_question(:marital_status)

    # Assert
    expect(marital_status_page).to be_displayed
  end

  # Scenario: Citizen update Savings and investment amount from Number of Children page
  #               Given I am ALLI
  #               And I am on the Number of Children page
  #               When I click on the Change link for the Savings and investment question
  #               Then I should see the Savings and investment question prepopulated with previous answer
  #               And answers to subsequent questions should be purged from the Previous answer section
  #
  scenario 'Citizen update Savings and investment amount from Number of Children page' do
    # Arrange
    given_i_am(:alli)
    answer_questions_up_to_number_of_children

    # Act
    number_of_children_page.go_back_to_question(:disposable_capital)

    # Assert
    expect(disposable_capital_page).to be_displayed
  end

  # Scenario: Citizen update Savings and investment amount from the Benefit response page
  #               Given I am JOHN
  #               And I am on the Benefit response page
  #               When I click on the Change link for the Savings and investment question
  #               Then I should see the Savings and investment question prepopulated with previous answer
  #               And answers to subsequent questions should be purged from the Previous answer section
  #
  scenario 'Citizen update Savings and investment amount from the Benefit response page' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_benefits

    # Act
    court_fee_page.go_back_to_question(:disposable_capital)

    # Assert
    expect(disposable_capital_page).to be_displayed
  end

  # Scenario: Citizen update Court or tribunal fee from the Total Income page
  #               Given I am JOHN
  #               And I am on the Total Income page
  #               When I click on the Change link for the Court or tribunal fee question
  #               Then I should see the Court or tribunal fee question prepopulated with previous answer
  #               And answers to subsequent questions should be purged from the Previous answer section
  #
  scenario 'Citizen update Court or tribunal fee from the Total Income page' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_total_income

    # Act
    total_income_page.go_back_to_question(:court_fee)

    # Assert
    expect(court_fee_page).to be_displayed
  end

  # Scenario: Citizen update income benefit from the Total Income page
  #               Given I am JOHN
  #               And I am on the Total Income page
  #               When I click on the Change link for the income benefit question
  #               Then I should see the income benefit question prepopulated with previous answer
  #               And answers to subsequent questions should be purged from the Previous answer section
  #
  scenario 'Citizen update income benefit from the Total Income page' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_total_income

    # Act
    total_income_page.go_back_to_question(:income_benefits)

    # Assert
    expect(income_benefits_page).to be_displayed
  end

  # Scenario: Citizen unable to make updates from the Total income response page
  #                Given I am THERESA
  #               When I navigate to the Income test response page
  #               Then I should see previous answers Change links disabled
  #
  #
  scenario 'Citizen unable to make updates from the Total income response page' do
    # Arrange
    given_i_am(:theresa)

    # Act
    answer_all_questions

    # Assert
    expect(full_remission_page.previous_answers).to be_disabled
  end

  # Scenario: Citizen unable to make updates from the disposable Capital test response page
  #                Given I am LOLA
  #               When I navigate to the disposable Capital test response page
  #               Then I should see previous answers Change links disabled
  scenario 'Citizen unable to make updates from the disposable Capital test response page' do
    # Arrange
    given_i_am(:lola)

    # Act
    answer_all_questions

    # Assert
    expect(not_eligible_page.previous_answers).to be_disabled
  end

end