require 'rails_helper'
#
# Income Benefit Page Content
#
# These specifications are content based specs, which will become
# more important when switching languages.
#
#
#
#
#
#
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
#
#
# Scenario: View Income Benefit Heading and Question
#
# Given I am JOHN
# And I am on the income benefits page
# When I view the Heading, Income Benefit question on the page
# Then Heading should read "How much help with fees will I receive"
# AND Income Benefit question reads "Select all income benefits you are currently receiving"
#
#
# Scenario: View Guidance Information
# GIVEN I am on the Income Benefit page
# WHEN I click on "Click to reveal more information" link
# THEN Guidance Information is displayed directly below the link
# AND link caption is changed to "Click to hide information"
#
#
#
# Scenario: Hide Guidance Information
# GIVEN I am on the Income Benefit page
# AND Guidance Information is displayed
# WHEN I click on the "Click to hide information" link
# THEN Guidance Information is hidden
# AND link caption is changed to "Click to reveal more information"
#
#
#
# #Guidance Information Content:
#
# Qualifying benefits are:
#                         Income-based Jobseeker’s Allowance (JSA)
# Income-related Employment and Support Allowance (ESA)
# Income Support
# Universal Credit (and you’re earning less than £6,000 a year)
# Pension Credit (guarantee credit)
# Scottish Legal Aid (Civil Claims)
# We’ll contact the Department for Work and Pensions to confirm that you are (or were) getting one of these benefits. We may also contact you if we need to see additional evidence.
#
#     If you are part of a couple and on a shared means-tested benefit please provide evidence of this when sending in your application. If you’ve only recently started receiving one of these benefits (for example, in the last few days), our staff may not be able to confirm  your eligibility with the Department for Work and Pensions. In this case  you should provide a letter from the Jobcentre Plus
#
#
#
# #Income Benefits Page Heading:
#
# How much help with fees will I receive?
# #Page Question:
#
# Select all income benefits you are currently receiving
#
#
# Scenario: Selecting None of the above option
# GIVEN I navigate to the income benefits page
# WHEN I select None of the above
#
# AND None of the above Guidance information is displayed
# AND I click on the Next step button
# THEN I am moved to the number of children question
#
#
#
# #None of the above content:
#
# If you are not receiving an income benefit, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you need to make towards paying the fee and therefore how much of the fee paid you should obtain a partial remission on
#
#
# Scenario: Selecting Don't Know
#       GIVEN I navigate to the income benefits page
#      WHEN I select Don't know
#
# AND Don't know Guidance information is displayed
#       AND I click on the Next step button
#      THEN I am moved to the number of children question
#
#
#
# #None of the above content:
#
# If you don't know if you are receiving an income benefit, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you need to make towards paying the fee and therefore how much of the fee paid you should obtain a partial remission on

RSpec.describe 'Income Benefit Page Content' do
  let(:start_page) { Calculator::Test::En::StartPage.new }
  let(:marital_status_page) { Calculator::Test::En::MaritalStatusPage.new }
  let(:court_fee_page) { Calculator::Test::En::CourtFeePage.new }
  let(:date_of_birth_page) { Calculator::Test::En::DateOfBirthPage.new }
  let(:disposable_capital_page) { Calculator::Test::En::DisposableCapitalPage.new }
  let(:income_benefits_page) { Calculator::Test::En::IncomeBenefitsPage.new }
  let(:next_page) { Calculator::Test::En::NumberOfChildrenPage.new }
  before do
    user = personas.fetch(:john)
    user.date_of_birth = (user.age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')

    start_page.load_page
    start_page.start_session

    marital_status_page.marital_status.set(user.marital_status)
    marital_status_page.next

    court_fee_page.fee.set(user.fee)
    court_fee_page.next

    date_of_birth_page.date_of_birth.set(user.date_of_birth)
    date_of_birth_page.next

    disposable_capital_page.disposable_capital.set(user.disposable_capital)
    disposable_capital_page.next
  end
  # Scenario: View Income Benefit Heading and Question
  #
  # Given I am JOHN
  # And I am on the income benefits page
  # When I view the Heading, Income Benefit question on the page
  # Then Heading should read "How much help with fees will I receive"
  # AND Income Benefit question reads "Select all income benefits you are currently receiving"
  scenario 'View Income Benefit Heading and Question' do
    # We will not validate the heading here, focus on one thing at a time
    expect(income_benefits_page.benefits.label.text).to eql messaging.t('hwf_pages.income_benefits.labels.benefits.question_label')
  end

  # Scenario: View Guidance Information
  # GIVEN I am on the Income Benefit page
  # WHEN I click on "Click to reveal more information" link
  # THEN Guidance Information is displayed directly below the link
  # AND link caption is changed to "Click to hide information"
  scenario "View Guidance Information" do
    my_page = income_benefits_page
    my_page.reveal_more_information.click
    expect(my_page.more_information).to be_present
    # We will not check caption change as next test will prove that by clicking it
  end

  # Scenario: Hide Guidance Information
  # GIVEN I am on the Income Benefit page
  # AND Guidance Information is displayed
  # WHEN I click on the "Click to hide information" link
  # THEN Guidance Information is hidden
  # AND link caption is changed to "Click to reveal more information"
  scenario "Hide Guidance Information" do
    my_page = income_benefits_page
    my_page.reveal_more_information.click
    my_page.more_information  # Will simply wait for this to be present
    my_page.hide_more_information.click
    expect(my_page.more_information).not_to be_present
  end

  # Scenario: Selecting None of the above option
  # GIVEN I navigate to the income benefits page
  # WHEN I select None of the above
  #
  # AND None of the above Guidance information is displayed
  # AND I click on the Next step button
  # THEN I am moved to the number of children question
  scenario 'Selecting none of the above option' do
    my_page = income_benefits_page
    my_page.choose_none
    expect(my_page.none_guidance).to be_present
  end

  scenario 'Selecting none of the above option and clicking next' do
    my_page = income_benefits_page
    my_page.choose_none
    my_page.next
    expect(next_page).to be_displayed
  end

  # Scenario: Selecting Don't Know
  #       GIVEN I navigate to the income benefits page
  #      WHEN I select Don't know
  #
  # AND Don't know Guidance information is displayed
  #       AND I click on the Next step button
  #      THEN I am moved to the number of children question
  scenario 'Selecting dont know' do
    my_page = income_benefits_page
    my_page.choose_dont_know
    expect(my_page.dont_know_guidance).to be_present
  end

  scenario 'Selecting dont know and clicking next' do
    my_page = income_benefits_page
    my_page.choose_dont_know
    expect(next_page).to be_displayed
  end
end