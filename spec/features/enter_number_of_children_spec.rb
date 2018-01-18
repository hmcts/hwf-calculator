require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-747
RSpec.describe 'Enter number of children test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::TotalIncomePage.new }
  # Feature: Number of Children responsible for supporting financially
  #
  # HwF eligibility Calculator should capture number of children citizen is responsible for supporting financially
  # The value is used in the income test calculation to derive the maximum contribution amount
  #
  #
  # Rules:
  #
  # Income test for part remission, full remission or no remission factors in the number of children citizen support financially
  # HwF calculator will add £245 for each child citizen have, to the minimum and maximum threshold for single and couple
  #
  #
  # Personas
  #
  # JOHN is a single, 56 year old man with 1 child. He is not on any benefit. He has £2,990 worth of capital and an income of £1,330. He has a court fee of £600
  #
  #
  #
  #
  # Scenario: Citizen enter number of children they are responsible for
  #               Given I am JOHN
  #               And I am on the Number of children page
  #               And I enter Number of children
  #               When I click on the Next step button
  #               Then I should see the next page
  scenario 'Citizen enter number of children they are responsible for' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:number_of_children)

    # Act
    answer_number_of_children_question

    # Assert
    expect(next_page).to be_displayed
  end
end
