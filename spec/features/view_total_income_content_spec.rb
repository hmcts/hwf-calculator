require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-680
RSpec.describe 'View total income content', type: :feature, js: true do
  # Feature: Total Income Page Content
  # Scenario: View Total Income Heading, Question and Hint text
  #               Given I am on the Total Income page
  #               When I view the heading, question and hint text on the page
  #               Then Heading should read "Find out if you could get help with fees"
  #               And question reads "How much total income do you receive each month?"
  #               And hint text reads "Enter how much gross income you get each month (before tax or National Insurance payments have been taken off)"
  scenario 'View Total Income Heading and Question' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_questions_up_to_total_income

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(total_income_page.heading).to be_present
      expect(total_income_page.total_income).to be_present
      expect(total_income_page.total_income.hint_with_text(messaging.t('hwf_pages.total_income.hint'))).to be_present
    end
  end

  #
  # Scenario: View Guidance Information
  #              Given I am on the Total Income page
  #              When I click on "What to include as income" link
  #              Then Guidance Information is displayed directly below the link
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_questions_up_to_total_income
    total_income_page.toggle_guidance

    # Assert
    expect(total_income_page.validate_guidance).to be true
  end

  # Scenario: Hide Guidance Information
  #               Given I am on the Total Income page
  #               And Guidance Information is displayed
  #               When I click on the "What to include as income" link
  #               Then Guidance Information is hidden
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_total_income
    total_income_page.toggle_guidance
    total_income_page.wait_for_guidance

    # Act
    total_income_page.toggle_guidance

    # Assert
    expect(total_income_page).to have_no_guidance
  end
  #
  # #Guidance Information Content:
  #
  # Write down how much money you get every month before any tax or National Insurance payments have been taken off.
  #
  # What to include as income:
  #
  # wages
  # some benefits
  # pensions (state, work or private without guarantee credit)
  # rent from anyone living with you and other properties that you own
  # payments from relatives
  # maintenance payments, eg from an ex-spouse
  # income from selling goods publicly or privately, including over the internet
  # student maintenance loans, grants or bursaries (except for tuition fee loans)
  # If you or your partner's income varies from month to month, work out an average monthly income based on the last 3 months. See what to include and exclude as income
  #
  # Total Income Page Heading:
  #
  # Find out if you could get help with fees
  # Page Question:
  #
  # How much total income do you receive each month?
end