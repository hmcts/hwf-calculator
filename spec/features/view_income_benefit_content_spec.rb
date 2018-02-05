require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-678
RSpec.describe 'Partner status content', type: :feature, js: true do
  # Feature: Income Benefit Page Content
  #
  #
  #
  # Personas
  #
  # JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  # ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  # OLIVER is a married, 75 year old man with £15,000 worth of capital. He has a court fee of £20,000
  # TOM is single, 80 year old man with £15,999 worth of capital. He has a court fee of £100
  # SUE is a married, 75 year old woman with £9,999 worth of capital. He has a court fee of £4,000
  #
  #
  # Scenario: View Income Benefit Heading and Question
  #
  #               Given I am JOHN
  #
  #               And I am on the income benefits page
  #
  #               When I view the Heading, Income Benefit question on the page
  #
  #               Then Heading should read "Find out if you could get help with fees"
  #
  #               And Income Benefit question reads "Select all income benefits you are currently receiving"
  scenario 'View Income Benefit Heading and Question' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:benefits)

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(income_benefits_page.heading).to be_present
      expect(income_benefits_page.benefits).to be_present
    end
  end

  #
  #
  # Scenario: View Guidance Information
  #             Given I am on the Income Benefit page
  #             When I click on "How benefit affects your claim" link
  #             Then Guidance Information is displayed directly below the link
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:benefits)
    income_benefits_page.toggle_guidance

    # Assert
    expect(income_benefits_page.validate_guidance).to be true
  end
  #
  #
  # Scenario: Hide Guidance Information
  #              Given I am on the Income Benefit page
  #              And Guidance Information is displayed
  #              When I click on the "How benefit affects your claim" link
  #              Then Guidance Information is hidden
  #
  #
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.toggle_guidance
    income_benefits_page.wait_for_guidance_text

    # Act
    income_benefits_page.toggle_guidance

    # Assert
    expect(income_benefits_page).to have_no_guidance_text
  end
  #
  # #Guidance Information Content:
  #
  # You are likely to get help with fees if you have no savings (or only a small amount of savings) and you are (or were at the time you paid the fee) receiving any of these benefits.
  #
  # When you apply, we’ll contact the Department for Work and Pensions to confirm that you are (or were at the time you paid the fee) getting any of these benefits. We may also contact you if we need to see additional evidence.
  #
  #
  #
  # #Income benefit Page Heading:
  #
  # Find out if you could get help with fees
  # #Page Question:
  #
  # Select all income benefits you are (or were at the time you paid the fee) receiving
  #
  #
  #
  #
  # #None of the above content:
  #
  # If you are not receiving one of the stated benefits, or are not sure, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you may need to make towards paying the fee
  #
  #
  # #Don't know content:(Revised)
  #
  # If you don't know if you're receiving an income benefit, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you may need to make towards paying the fee
end
