require 'rails_helper'
# This feature represents the acceptance criteria defined in 
# The welsh version is RST-819
RSpec.describe 'Savings and investments content', type: :feature, js: true do
  # Feature: Savings & investments Page Content
  #
  #
  #
  # Scenario: View Savings and investments Heading, Question and Hint text
  #              Given I am on the Savings and investments page
  #              When I view the Heading, Question and Hint text
  #              Then Heading reads "Find out if you could get help with fees"
  #              And question reads "How much do you have in savings and investments combined"
  #              And Hint text reads "If you have more than £16,000 in savings and investments, then you are unlikely to get help with your fee"
  #
  #
  scenario 'View Savings and investments Heading and Question for single user' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:disposable_capital)

    # Assert
    aggregate_failures 'validating content of header, question and hint text' do
      expect(disposable_capital_page.heading).to be_present
      expect(disposable_capital_page.disposable_capital_single).to be_present
      expect(disposable_capital_page.disposable_capital_single).to have_hint
    end
  end

  scenario 'View Savings and investments Heading and Question for married user' do
    # Arrange
    given_i_am(:alli)

    # Act
    answer_up_to(:disposable_capital)

    # Assert
    aggregate_failures 'validating content of header, question and hint text' do
      expect(disposable_capital_page.heading).to be_present
      expect(disposable_capital_page.disposable_capital_married).to be_present
      expect(disposable_capital_page.disposable_capital_married).to have_hint
    end
  end

  #
  # Scenario: View Guidance Information
  #              Given I am on the Savings and investments page
  #              When I click on "Help with savings and investments" link
  #              Then Guidance Information is displayed directly below the link
  #
  scenario 'View Guidance Information' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:disposable_capital)
    disposable_capital_page.toggle_guidance

    # Assert
    expect(disposable_capital_page.validate_guidance).to be true
  end

  # Scenario: Hide Guidance Information
  #               Given I am on the Savings and investments page
  #               And Guidance Information is displayed
  #               When I click on the "Help with savings and investments" link
  #               Then Guidance Information is hidden
  #
  #
  # Guidance Information Content:
  #
  # You should include any of the following:
  #
  # money in ISAs and any other savings account
  # joint savings accounts that you share with your partner
  # fixed rate or investment bonds
  # any lump sum (eg a redundancy payout)
  # stocks and shares
  # trust funds (or any other kind of fund)
  # capital value of additional property
  # money or property outside the UK
  #
  # You should exclude:
  #
  # wages or benefits
  # joint savings accounts that you share with your partner if your case concerns divorce or gender recognition
  # personal pensions
  # capital value of self-employed businesses
  # student loans
  # unfair dismissal awards
  # money from the criminal injury compensation scheme
  # medical negligence or personal injury awards
  # any compensation under a statutory scheme in respect of Mesothelioma
  #
  #
  scenario 'Hide Guidance Information' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:disposable_capital)
    disposable_capital_page.toggle_guidance
    disposable_capital_page.wait_for_guidance_text

    # Act
    disposable_capital_page.toggle_guidance

    # Assert
    expect(disposable_capital_page).to have_no_guidance_text
  end
  # Savings and investments Page Heading:
  #  Find out if you could get help with fees
  #
  # Page Question:
  # How much do you have in savings and investments combined?
  #
  # Hint text:
  # If you have more that £16,000 in savings and investments, then you are unlikely to get help with your fee
end
