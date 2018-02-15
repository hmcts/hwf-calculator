require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-721
RSpec.describe 'Partner Status Test', type: :feature, js: true do
  # Feature: Partner Status
  #
  # Ability for citizen to confirm their Partner status
  #
  #
  # Personas:
  #
  #   JOHN is a single, 56 year old man with 1 child. He is not on any benefit. He has £2,990 worth of capital and an income of £1,330. He has a court fee of £600
  #   ALLI is a married, 60 year old man with 1 child. He is not on any benefit. He has £3,800 worth of capital and an income of £1,489. He has a court fee of £1,334
  #   SUE is a married, 75 year old woman with 0 children and partner is 73 years old. She is not on any benefit. She has £9,999 worth of capital and an income of £0. She has a court fee of £4,000
  #
  # Scenario: JOHN confirms he is single
  # Given I am John
  # And I am on the Partner Status page
  # And I select Single option
  # When I click Next Step
  # Then I should see the next page
  let(:next_page) { Calculator::Test::CourtFeePage.new }

  scenario 'John confirms he is single' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:marital_status)

    # Act
    marital_status_page.marital_status.set(:single)
    marital_status_page.next

    # Assert
    expect(next_page).to be_displayed
  end

  #
  # Scenario: ALLI confirms he is married
  # Given I am Alli and partner
  # And I am on the Partner Status page
  # And I select Married or living with someone option
  # When I click Next Step
  # Then I should see the next page
  #
  scenario 'Alli confirms he is married' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:marital_status)

    # Act
    marital_status_page.marital_status.set(:sharing_income)
    marital_status_page.next

    # Assert
    expect(next_page).to be_displayed
  end
end
