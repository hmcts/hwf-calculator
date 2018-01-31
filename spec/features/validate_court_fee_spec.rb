require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-725
RSpec.describe 'Validate court fee test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::DateOfBirthPage.new }

  #
  # Feature: Court and tribunal fee field tool tip/Hint text
  # Validate the Court and tribunal fee field at the form level
  #
  # @TODO Implement the scenario below as part of RST-744 then remove this comment
  # Scenario: Court and tribunal fee field tool tip
  #               Given I navigate to the Court and tribunal fee question
  #               And focus is away from the Court and tribunal fee field
  #               When I view the Court and tribunal fee field
  #               Then I should see tooltip displayed in the field
  #  Tooltip content: "£ Please enter a number between 0 and 100,000 (no decimal places)".
  #  Proposed content: "£ Enter numeric value with no decimal places"
  #
  # Scenario: Enter numeric value in Court and tribunal fee field
  #               Given I navigate to the Court and tribunal fee question
  #               And click in the Court and tribunal fee field
  #               When I enter numeric value in the field
  #               And click on the Next step button
  #               Then the value in the field is validated
  #               And I should see the next page
  #  Default value on field selection: "£"
  scenario 'Enter numeric value in Court and tribunal fee field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:court_fee)

    # Act
    court_fee_page.fee.set("25")
    court_fee_page.next

    # Assert
    expect(next_page).to be_displayed
  end
  #
  # Scenario: Enter non-numeric value in Court and tribunal fee field
  #               Given I navigate to the Court and tribunal fee question
  #               And click in the Court and tribunal fee field
  #               When I enter non-numeric value in the field
  #               And click on the Next step button
  #               Then the value in the field is validated
  #               And error message displayed prompting me to enter numeric value
  # Error Message: "Please enter numeric value with no decimal places"
  scenario 'Enter non-numeric value in Court and tribunal fee field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:court_fee)

    # Act
    court_fee_page.fee.set("£")
    court_fee_page.next

    # Assert
    expect(court_fee_page).to have_error_with_text(:non_numeric)
  end
  #
  # Scenario: Court and tribunal fee field empty
  #               Given I navigate to the Court and tribunal fee question
  #               When I leave Court and tribunal fee field empty
  #               And click on the Next step button
  #               Then error message is displayed prompting me to enter numeric value
  # Error Message: "Please enter numeric value with no decimal places"
  #
  scenario 'Court and tribunal fee field empty' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:court_fee)

    # Act
    court_fee_page.next

    # Assert
    expect(court_fee_page).to have_error_with_text(:non_numeric)
  end
end
