require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-680
RSpec.describe 'View total income content', type: :feature, js: true do
  # Feature: Total Income Page Content
  #
  # Scenario: View Total Income Heading and Question
  #             GIVEN I am on the Total Income page
  #             WHEN I view the Heading, total income question on the page
  #             THEN Heading should read "How much help with fees will I receive?"
  #             AND total Income question reads "How much total income do you receive each month"
  #
  scenario 'View Total Income Heading and Question' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_questions_up_to_total_income

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(total_income_page.heading).to be_present
      expect(total_income_page.total_income).to be_present
    end
  end

  #
  # Scenario: View Guidance Information
  #             GIVEN I am on the Total Income page
  #              WHEN I click on "Click to reveal more information" link
  #             THEN Guidance Information is displayed directly below the link
  #             AND link caption is changed to "Click to hide information"
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

  #
  # Scenario: View Hint text
  #              GIVEN I am on the Total Income page
  #              WHEN I click on "Click to reveal more information" link
  #             THEN Guidance Information is displayed directly below the link
  #             AND link caption is changed to "Click to hide information"
  #
  #
  scenario 'View Hint text' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_questions_up_to_total_income

    # Assert
    expect(total_income_page.total_income.hint_with_text(messaging.t('hwf_pages.total_income.hint'))).to be_present
  end

  #
  # Scenario: Hide Guidance Information
  #              GIVEN I am on the Total Income page
  #               AND Guidance Information is displayed
  #              WHEN I click on the "Click to hide information" link
  #              THEN Guidance Information is hidden
  #              AND link caption is changed to "Click to reveal more information"
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
  # Write down how much money you get every month before any tax or National Insurance payments have been taken off. What to include as income:
  # wages
  # some benefits (see the list in the guide for benefits you shouldn’t include)
  # pensions (state, work or private without guarantee credit)
  # rent from anyone living with you and other properties that you own
  # payments from relatives
  # maintenance payments, eg from an ex-spouse
  # income from selling goods publicly or privately, including over the internet
  # student maintenance loans, grants or bursaries (except for tuition fee loans)
  # If you or your partner's income varies from month to month, work out an average monthly income based on the last 3 months. See the guide for further details of what to include and exclude.
  #
  # #Total Income Page Heading:
  #
  # How much help with fees will I receive?
  # #Page Question:
  #
  # How much total income do you receive each month?
end