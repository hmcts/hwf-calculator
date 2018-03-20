require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-701
RSpec.describe 'Landing page content', type: :feature, js: true do

  # Feature: HwF Eligibility Calculator Landing page Content
  #
  #
  #
  # Scenario: View Heading, Body, Disclaimer and Welsh translation link on the Calculator Landing Page (Revised)
  #              Given I am on the HwF Calculator landing page
  #              When I view the Heading, Body, Disclaimer and Welsh translation link (Revised)
  #              Then Heading should read "Find out if you could get help with fees"
  #              And body should display information about the calculator
  #              And Disclaimer display "This isn't the application and ......." (New)
  #              And Welsh translation link display "This guide is also available in Welsh (Cymraeg)" (New)
  #
  #
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
  # Disclaimer  (Revised)
  #
  # This calculator is for guidance purposes only and is not the Help with Fees application
  #
  #
  #
  # Welsh Translation link (New)**
  #
  # This guide is also available in Welsh (Cymraeg)
  #
  #
  #
  # NOTE to DEV (New)**
  #
  # "in Welsh" should be a link that enables the welsh translation of the calculator

  # Scenario: View Heading, Body, Disclaimer and Welsh translation link on the Calculator Landing Page (Revised)
  #              Given I am on the HwF Calculator landing page
  #              When I view the Heading, Body, Disclaimer and Welsh translation link (Revised)
  #              Then Heading should read "Find out if you could get help with fees"
  #              And body should display information about the calculator
  #              And Disclaimer display "This isn't the application and ......." (New)
  #              And Welsh translation link display "This guide is also available in Welsh (Cymraeg)" (New)
  #
  #
  scenario 'View Heading, Body, Disclaimer and Welsh translation link on the Calculator Landing Page' do
    # Act
    load_start_page

    # Assert
    aggregate_failures 'Validating headers, content, disclaimer and welsh link' do
      expect(start_page).to have_heading
      expect(start_page.validate_introduction).to be true
      expect(start_page.validate_requirements).to be true
      expect(start_page.validate_disclaimer).to be true
      expect(start_page.validate_welsh_link).to be true
    end

  end

  scenario 'Verify caching is not disabled using NON JS BROWSER', js: false do
    # Act
    load_start_page

    # Assert
    expect(start_page).to have_cache
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
  # Disclaimer  (Revised)
  #
  # This calculator is for guidance purposes only and is not the Help with Fees application
  #
  #
  #
  # Welsh Translation link (New)**
  #
  # This guide is also available in Welsh (Cymraeg)

end
