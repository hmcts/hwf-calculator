require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-794
RSpec.describe 'Validate partner status test', type: :feature, js: true do
  let(:next_page) { Calculator::Test::En::CourtFeePage.new }

  # Personas
  #
  # JOHN is a single, 56 year old man with 1 child
  # ALLI is a married, 60 year old man with 1 child
  # SUE is a married, 75 year old woman with 0 children
  #
  #
  # Scenario: Select Single Marital status option
  #          Given I am JOHN
  #          And I am on the Marital status question
  #          And I select Single option
  #          When I click on the Next step button
  #          Then I should see the next question
  scenario 'Select Single Marital status option' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:marital_status)

    # Act
    marital_status_page.marital_status.set(:single)
    marital_status_page.next

    # Assert
    expect(next_page).to be_present
  end

  #
  # Scenario: Select Married Marital status option
  #          Given I am ALLI
  #          And I am on the Marital status question
  #          And I select "Married or living with someone" option
  #          When I click on the Next step button
  #          Then I should see the next question
  #
  scenario 'Select Married Marital status option' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:marital_status)

    # Act
    marital_status_page.marital_status.set(:sharing_income)
    marital_status_page.next

    # Assert
    expect(next_page).to be_present
  end

  # Scenario: No selection of Marital status option (no entry)
  #          Given I am JOHN
  #          And I am on the Marital status question
  #          And I don't select any option
  #          When I click on the Next step button
  #          Then I should see an error message
  #
  #      Error Message: "Select whether you're single, married or living with someone and sharing an income"
  scenario 'No selection of Marital status option (no entry)' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:marital_status)

    # Act
    marital_status_page.next

    # Assert
    expect(marital_status_page).to have_error_with_text(:blank)
  end

end
