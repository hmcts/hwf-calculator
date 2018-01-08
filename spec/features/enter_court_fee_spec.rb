require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-723
RSpec.describe 'Enter court fee test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::DateOfBirthPage.new }
  # Feature: Court or Tribunal Fee
  #   HwF eligibility Calculator should capture court or tribunal fees to check citizen eligibility for help with fees
  #
  # Rules:
  #     Court or tribunal fees band is categorised based on citizen's age
  #     For citizens (and partner) under 61 years old, the minimum and maximum fee band apply with corresponding disposable capital threshold
  #     For citizen (and partner) who are 61 and over, there is no limit to the court and tribunal fee band. However, it must comply with corresponding disposable capital threshold
  #
  # Personas
  #   JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  #   ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  #
  #   Scenario: Single citizen enter court and tribunal fee amount
  #                 Given I am JOHN
  #                 And I am on the court and tribunal fee page
  #                 And I fill in the court and tribunal page
  #                 When I click on the Next step button
  #                 Then I should see the DoB page
  #                 And DoB page should display one set of DoB fields
  #
  scenario 'Single citizen enter court and tribunal fee amount' do
    # Setup
    given_i_am(:john)
    answer_questions_up_to_court_fee

    # Act
    answer_court_fee_question

    # Assert
    expect(next_page).to be_displayed
  end

  #   Scenario: Married citizen enter court and tribunal fee amount
  #                 Given I am ALLI
  #                 And I am on the court and tribunal fee page
  #                 And I fill in the court and tribunal page
  #                 When I click on the Next step button
  #                 Then I should see the DoB page
  #                 And DoB page should display two sets of DoB fields
  scenario 'Married citizen enter court and tribunal fee amount' do
    # Setup
    given_i_am(:alli)
    answer_questions_up_to_court_fee

    # Act
    answer_court_fee_question

    # Assert
    expect(next_page).to be_displayed
  end
end
