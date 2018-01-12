require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-701
RSpec.describe 'Partner status content', type: :feature, js: true do
  # Feature: HwF Eligibility Calculator Landing page Content
  #
  #
  #
  # Scenario: View and validate Calculator Landing Page content
  #              Given I am on the HwF Calculator landing page
  #              When I view the content on the page
  #             Then Heading should read "Find out if you could get help with fees?"
  #             And body should display information about the calculator
  #
  #
  scenario 'View and validate Calculator Landing Page content' do
    # Act
    start_page.load_page

    # Assert
    aggregate_failures 'Validating headers and content' do
      expect(start_page).to have_heading
      expect(start_page.validate_introduction).to be true
      expect(start_page.validate_requirements).to be true
    end

  end
  #
  # Heading (Revised)
  #
  # Find out if you could get help with fees
  #
  #
  #
  # Body: (Revised)**
  #
  # This calculator will tell you if you’re likely to get help with fees and how much you could get.
  #
  # You may be able to get money off the cost of a court or tribunal fee, or have the fee waived in full, if:
  #
  # You don't have much in savings, and
  # You're receiving certain benefits, or
  # You're on a low income
  # If you have a partner, your partner's situation will also apply
  #
  # What you’ll need (Revised)**
  #
  # You'll need information about your (and your partner's, if applicable):
  #
  #  total savings amount, and
  #  either: list of benefits (or proof of certain benefits at the time you paid your fee)
  #  or: total monthly income"
  #
  #
end
