require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-749
RSpec.describe 'View number of children question content', type: :feature, js: true do
  # Feature: Number of Children Page Content
  #
  #
  #
  # Scenario: View Number of Children Heading and Question
  #               Given I am on the Number of Children page
  #               When I view the Heading and Number of Children question
  #               Then Heading reads "Find out if you can get help with fees"
  #               And question reads "How many children live with you or are you responsible for supporting financially?"
  scenario 'View Number of Children Heading and Question' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:number_of_children)

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(number_of_children_page.heading).to be_present
      expect(number_of_children_page.number_of_children).to be_present
    end
  end
  #
  # Scenario: View Guidance Information
  #              Given I am on the Number of Children page
  #              When I click on "Children who might affect your claim" link
  #              Then Guidance Information is displayed directly below the link
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:number_of_children)
    number_of_children_page.toggle_guidance

    # Assert
    expect(number_of_children_page.validate_guidance).to be true
  end
  # Scenario: Hide Guidance Information
  #               Given I am on the Number of Children page
  #               And Guidance Information is displayed
  #               When I click on "Children who might affect your claim" link
  #               Then Guidance Information is hidden
  #
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:number_of_children)
    number_of_children_page.toggle_guidance
    number_of_children_page.wait_for_guidance

    # Act
    number_of_children_page.toggle_guidance

    # Assert
    expect(number_of_children_page).to have_no_guidance
  end

  # Number of Children Heading:
  #
  #  Find out if you can get help with fees
  #
  #
  # Page Question:
  #
  # How many children live with you or are you responsible for supporting financially?
  #
  #
  # Guidance Information Content:
  #
  # Enter the number of children who you describe as:
  # under 16 and living at home with you
  # age 16-19, single, living at home with you and in full-time education (not including studying for a degree or other higher education qualification)
  # children who don’t live with you, but you (or your partner) pay regular maintenance for them
end
