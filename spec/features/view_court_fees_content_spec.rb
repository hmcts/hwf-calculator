require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-724
# The welsh version is RST-817
RSpec.describe 'Court fees content', type: :feature, js: true do
  # Feature: Court or Tribunal fee Page Content
  #
  #
  #
  # Scenario: View Court or Tribunal fee Heading, Question and Hint text
  #
  #               Given I am on the Court or Tribunal fee page
  #
  #               When I view the Heading, Court or Tribunal fee question and Hint text on the page
  #
  #               Then Heading should read "Find out if you could get help with fees"
  #
  #               And Court or Tribunal fee question reads "How much is the court or tribunal fee?"
  #
  #               And Hint text reads "Enter valid value with no decimal places"
  scenario 'View Court or Tribunal fee Heading, Question and Hint text' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:court_fee)

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(court_fee_page.heading).to be_present
      expect(court_fee_page.fee).to be_present
      expect(court_fee_page.fee).to have_hint
    end
  end
  #
  #
  #
  # Scenario: View Guidance Information
  #
  #               Given I am on the Court or Tribunal fee page
  #
  #               When I click on "If you have already paid your court or tribunal fee" link
  #
  #               Then Guidance Information is displayed directly below the link
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:court_fee)
    court_fee_page.toggle_guidance

    # Assert
    expect(court_fee_page.validate_guidance).to be true
  end
  #
  #
  #
  # Scenario: Hide Guidance Information
  #
  #               Given I am on the Court or Tribunal fee page
  #
  #               And Guidance Information is displayed
  #
  #               When I click on the "If you have already paid your court or tribunal fee" link
  #
  #               Then Guidance Information is hidden
  #
  #
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:court_fee)
    court_fee_page.toggle_guidance
    court_fee_page.wait_for_guidance_text

    # Act
    court_fee_page.toggle_guidance

    # Assert
    expect(court_fee_page).to have_no_guidance_text
  end

  #
  # Guidance Information Content:
  # You can apply to get some, or all of your money back, if you’ve paid a fee in the last 3 months. However, you must have been eligible when you paid the fee and so you should answer questions about your circumstances at the time you paid the fee.
  #
  #
  #
  # Court or Tribunal fee Heading:
  # Find out if you could get help with fees
  #
  #
  #
  # Page Question:
  # How much is the court or tribunal fee?

end
