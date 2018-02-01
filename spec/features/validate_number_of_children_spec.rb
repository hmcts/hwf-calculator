require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-752
RSpec.describe 'Validate court fee test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::TotalIncomePage.new }

  # Personas
  #
  # JOHN is a single, 56 year old man with 1 child
  # ALLI is a married, 60 year old man with 1 child
  # OLIVER is a married, 75 year old man with 4 children.
  #
  #
  # Scenario: Enter valid value in the Number of children field
  #         Given I am JOHN
  #         And I am on the Number of children question
  #         And I enter numeric value in the field
  #         When I click on the Next step button
  #         Then I should see the next question
  scenario 'Enter valid value in the Number of children field' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:number_of_children)

    # Act
    answer_number_of_children_question

    # Assert
    expect(next_page).to be_displayed
  end
  #
  #
  #
  # Scenario: Enter invalid value in the Number of children field
  #         Given I am ALLI
  #         And I am on the Number of children question
  #         And I enter non-numeric value in the field
  #         When I click on the Next step button
  #         Then I should see an error message
  #
  #       Error Message: "You must enter the number of financially dependent children"
  scenario 'Enter invalid value in the Number of children field' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:number_of_children)

    # Act
    number_of_children_page.number_of_children.set('£')
    number_of_children_page.next

    # Assert
    expect(number_of_children_page.number_of_children).to have_error_non_numeric
  end
  #
  # Scenario: Number of children field empty - Blank Field (no entry)
  #         Given I am OLIVER
  #         And I am on the Number of children question
  #         And I leave Number of children field blank
  #         When I click on the Next step button
  #         Then I should see an error message
  #
  #      Error Message: "You must enter the number of financially dependent children"
  scenario 'Number of children field empty - Blank Field (no entry)' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:number_of_children)

    # Act
    number_of_children_page.next

    # Assert
    expect(number_of_children_page.number_of_children).to have_error_blank
  end
end