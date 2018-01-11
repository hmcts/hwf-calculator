require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-675
RSpec.describe 'Partner status content', type: :feature, js: true do
  #
  # Guidance Information Content:
  #
  # Single means you rely on your own income, single also means:
  #
  # you are going through divorce, or your marriage is dissolved or annulled (unless you have married again or live with a new partner)
  # you are changing your legal gender
  # you are experiencing domestic violence
  # you are experiencing forced marriage
  # Married or living with someone and sharing an income means:
  #
  # married
  # civil partners
  # living together as if you are married or in a civil partnership
  # living at the same address with a joint income
  # part of a couple forced to live apart, eg where one or both is serving in the Armed forces, in prison or living in residential care
  #
  #
  # Partner Status Page Heading:
  #
  # Find out if you can get help with fees
  #
  #
  # Page Question:
  #
  # Are you single, or any of: married or living with someone and sharing an income

  # Feature:
  #
  # Partner Status Content
  #
  #
  # Scenario: View Partner Status Heading and Question
  #
  #               Given I am on the Partner Status page
  #
  #               When I view the Heading, Partner status question on the page
  #
  #               Then Heading should read "Find out if you can get help with fees"
  #
  #               And Partner Status question reads "Are you single, married or living with someone and sharing income"
  scenario 'View Partner Status Heading and Question' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to_marital_status_question

    # Assert
    aggregate_failures 'validating content of header and question' do
      expect(marital_status_page.heading).to be_present
      expect(marital_status_page.marital_status).to be_present
    end
  end
  #
  #
  #
  # Scenario: View Guidance Information
  #
  #               Given I am on the Partner Status page
  #
  #               When I click on "Help with Status" link
  #
  #               Then Guidance Information is displayed directly below the Help with status link
  #
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to_marital_status_question
    marital_status_page.toggle_guidance

    # Assert
    expect(marital_status_page.validate_guidance).to be true
  end

  # Scenario: Hide Guidance Information
  #
  #               Given I am on the Partner Status page
  #
  #               And Guidance Information is displayed
  #
  #               When I click on the "Help with Status" link
  #
  #               Then Guidance Information is hidden
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_up_to_marital_status_question
    marital_status_page.toggle_guidance
    marital_status_page.wait_for_guidance

    # Act
    marital_status_page.toggle_guidance

    # Assert
    expect(marital_status_page).to have_no_guidance
  end
end
