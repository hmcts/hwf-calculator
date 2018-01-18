require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-726
RSpec.describe 'Enter date of birth spec', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::DisposableCapitalPage.new }

  # Feature: Date of Birth
  # HwF eligibility Calculator should capture date of birth of citizen and partner to check citizen eligibility for help with fees
  #
  # Rules:
  # Date of birth field display should be based on previous answer in the status page
  # If user select Single option in question 1, then only one set of DoB field should surface for user entry
  # If user select Married or living with someone option in question 1, then  two sets of DoB field should surface for user entry
  #
  # Personas
  # JOHN is a single, 56 year old man
  # ALLI is a married, 60 year old man with partner who is 50 year old
  #
  # Scenario: Single citizen enter date of birth
  #               Given I am JOHN
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  scenario 'Single citizen enter date of birth' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end
  #
  # Scenario: Married citizen enter date of birth
  #               Given I am ALLI
  #               And I am on the date of birth page
  #               And I fill in my date of birth
  #               And I fill in my partner date of birth
  #               When I click on the Next step button
  #               Then I should see the next page
  scenario 'Married citizen enter date of birth' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:date_of_birth)

    # Act
    answer_date_of_birth_question

    # Assert
    expect(next_page).to be_displayed
  end
end
