require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-834
RSpec.describe 'Next steps test', type: :feature, js: true do
  # Feature: HwF Calculator Next Steps link
  # HwF eligibility Calculator should be able to return users back to the HwF home page from the response pages
  #
  # Personas
  # WILLIAM is a single, 56 year old man with 1 child. He is on Job Seeker allowance & Income support. He has £2,900 worth of capital. He has a court fee of £600
  # JAMES is a single, 45 year old man with 0 children. He is not on income benefit. He has £4,999 worth of capital and an income of £1,084. He has a court fee of £1,664
  # LANDON is a married, 50 year old man with 0 children. He is not on income benefit. He has £9,600 worth of capital and an income of £5,244. He has a court fee of £4,900
  # JOSEPH is a single, 35 year old man with 2 children. He is not on income benefit. He has £13,999 worth of capital and an income of £8,000. He has a court fee of £7,000
  # LOLA is a married, 90 year old woman with £19,000 worth of capital. She has a court fee of £100,000
  #
  #
  # Scenario: User who fail disposable capital test can return to the HwF home page
  #          Given I am LOLA
  #          And I am on the savings and investment response page
  #          When I click on the "Return to Help with fees home page" link
  #          Then I should see the Help with fees home page
  scenario 'User who fail disposable capital test can return to the HwF home page' do
    # Arrange
    given_i_am :lola
    answer_up_to :disposable_capital
    answer_disposable_capital_question

    # Act
    not_eligible_page.start_again

    # Assert
    expect(start_page).to be_displayed
  end

  # Scenario: User who pass income test and eligible for full remission
  #          Given I am JAMES
  #          And I am on the total income response page
  #          When I click on the "Return to Help with fees home page" link
  #          Then I should see the Help with fees home page
  #
  scenario 'User who pass income test and eligible for full remission' do
    # Arrange
    given_i_am :james
    answer_up_to :total_income
    answer_total_income_question

    # Act
    full_remission_page.start_again

    # Assert
    expect(start_page).to be_displayed
  end
  # Scenario: User who pass income test and eligible for partial remission
  #          Given I am LANDON
  #          And I am on the total income response page
  #          When I click on the "Return to Help with fees home page" link
  #          Then I should see the Help with fees home page
  #
  scenario 'User who pass income test and eligible for partial remission' do
    # Arrange
    given_i_am :landon
    answer_up_to :total_income
    answer_total_income_question

    # Act
    partial_remission_page.start_again

    # Assert
    expect(start_page).to be_displayed
  end
  # Scenario: User who fail income test and not eligible for fee remission
  #          Given I am JOSEPH
  #          And I am on the total income response page
  #          When I click on the "Return to Help with fees home page" link
  #          Then I should see the Help with fees home page
  #
  scenario 'User who fail income test and not eligible for fee remission' do
    # Arrange
    given_i_am :joseph
    answer_up_to :total_income
    answer_total_income_question

    # Act
    not_eligible_page.start_again

    # Assert
    expect(start_page).to be_displayed
  end
  # Scenario: User who is eligible for fee exemption can return to the HwF home page
  #          Given I am WILLIAM
  #           And I am on the income benefits response page
  #          When I click on the "Return to Help with fees home page" link
  #          Then I should see the Help with fees home page
  #
  scenario 'User who is eligible for fee exemption can return to the HwF home page' do
    # Arrange
    given_i_am :william
    answer_up_to :benefits
    answer_benefits_question

    # Act
    full_remission_page.start_again

    # Assert
    expect(start_page).to be_displayed
  end
end
