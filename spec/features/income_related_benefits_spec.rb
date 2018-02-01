require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-677
RSpec.describe 'Income Benefit Page Content', type: :feature, js: true do
  include Calculator::Test::Pages
  # The next page is always the number of children
  let(:next_page) { Calculator::Test::En::NumberOfChildrenPage.new }

  #
  #   # Feature : Income Related Benefits
  #   # Citizens may be exempted from Court or Tribunal fees if they pass the Disposable Capital test and receive one of six income related benefits below:
  #   # Income-based Jobseeker's Allowance
  #   # Income-related Employment and Support Allowance (ESA)
  #   # Income Support
  #   # Universal Credit
  #   # Pension Credit
  #   # Scottish Civil Legal Aid
  #   #
  #   # Rules:
  #   # Prior to fee exemption check, citizens should have passed disposable capital test
  #   # Citizens who are exempted from paying court fees will get full remission
  #   #
  #   # Personas
  #   # JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  #   # ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  #   # OLIVER is a married, 75 year old man with £15,000 worth of capital. He has a court fee of £20,000
  #   # TOM is single, 80 year old man with £15,999 worth of capital. He has a court fee of £100
  #   # SUE is a married, 75 year old woman with £9,999 worth of capital. He has a court fee of £4,000
  #   #
  #   # Messaging
  #   # Positive (On Benefit)
  #   # You may be eligible for a full remission
  #   # Positive decision: As you have indicated you receive an income benefit, with a fee of £XXX, you should be entitled to a full remission or a full refund if you have paid the fee within the last 3 months.
  #   # Negative (Not on income Benefit)
  #   # Selecting: None of the above
  #   # If you are not receiving an income benefit, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you may need to make towards paying the fee, and therefore how much of the fee you may obtain a remission on (if any)
  #   #
  #   # Negative (Not on income Benefit)
  #   # Selecting: Don't know
  #   # If you don't know if you are receiving an income benefit, we will need to ask you further questions regarding any children you are responsible for and your income. This will tell us the maximum contribution you may need to make towards paying the fee, and therefore how much of the fee you may obtain a remission on (if any)
  #

  # Scenario: Unselect None of the above option (Revised)
  #   Given I am JOHN
  #   And I am on the income benefits page
  #               And I select None of the above
  #   When I select one or more income related benefit options
  #               Then the None of the above option is unselected
  #                And income related benefit options are selected
  scenario 'Unselect None of the above option when benefits chosen' do
    # Arrange - Get john to the benefits page
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.choose :none

    # Act
    income_benefits_page.choose(:jobseekers_allowance, :pension_credit)

    # Assert
    expect(income_benefits_page).to have_selected(:jobseekers_allowance, :pension_credit)
  end

  scenario 'Unselect None of the above option when dont know chosen' do
    # Arrange - Get john to the benefits page
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.choose :none

    # Act
    income_benefits_page.choose(:dont_know)

    # Assert
    expect(income_benefits_page).to have_selected(:dont_know)
  end

  # Scenario: Unselect Don't know option (New)
  #               Given I am JOHN
  # And I am on the income benefits page
  #               And I select Don't know
  #               When I select one or more income related benefit options
  #               Then the Don't know option is unselected
  #                And income related benefit options are selected
  scenario 'Unselect dont know option when benefits chosen' do
    # Arrange - Get john to the benefits page
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.choose(:dont_know)

    # Act
    income_benefits_page.choose(:jobseekers_allowance, :pension_credit)

    # Assert
    expect(income_benefits_page).to have_selected(:jobseekers_allowance, :pension_credit)
  end

  scenario 'Unselect dont know option when none chosen' do
    # Arrange - Get john to the benefits page
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.choose(:dont_know)

    # Act
    income_benefits_page.choose(:none)

    # Assert
    expect(income_benefits_page).to have_selected(:none)
  end

  # Scenario: Unselect Income benefit options (New)
  #
  #               Given I am JOHN
  #               And I am on the income benefits page
  #               And I select one or more income related benefit options
  #               When I select None of the above
  #               Then the selected income related benefit options are unselected
  #               And None of the above option is selected
  #
  scenario 'Unselect income benefit option option' do
    # Arrange - Get john to the benefits page
    given_i_am(:john)
    answer_up_to(:benefits)
    income_benefits_page.choose(:jobseekers_allowance, :pension_credit)

    # Act
    income_benefits_page.choose(:none)

    # Assert
    expect(income_benefits_page).to have_selected(:none)
  end

  #
  # Scenario: Select None of the Above option
  #               Given I am ALLI
  #               And I am on the income benefits page
  #               And I select None of the above
  #               When I click on the Next step button
  #               Then I should see the next question
  scenario 'Select None of the Above option' do
    # Arrange - Take alli to the benefits page
    given_i_am(:alli)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:none)
    income_benefits_page.next

    # Assert
    expect(next_page).to be_displayed
  end
  #
  # Scenario: Select Don't Know option
  #
  #               Given I am ALLI
  #               And I am on the income benefits page
  #               And I select Don't Know
  #               When I click on the Next step button
  #               Then I should see the next question
  #
  scenario 'Select dont know option' do
    # Arrange - Take alli to the benefits page
    given_i_am(:alli)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:dont_know)
    income_benefits_page.next

    # Assert
    expect(next_page).to be_displayed
  end

  # Scenario: Select income related benefit option
  # Given I am OLIVER
  # And I am on the income benefits page
  # And I select income related benefit
  # When I click on the Next step button
  # Then I should see that I am eligible for a full remission
  #  And income benefit question, selected answer appended to the Previous answers section
  scenario 'Select income related benefit option - ensuring full remission' do
    # Arrange - Take oliver to the benefits page
    given_i_am(:oliver)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:jobseekers_allowance)
    income_benefits_page.next

    # Assert
    expect(full_remission_page).to be_displayed
  end

  scenario 'Select income related benefit option - answer added to previous answers' do
    # Arrange - Take oliver to the benefits page
    given_i_am(:oliver)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:jobseekers_allowance)
    income_benefits_page.next

    # Assert
    expect(full_remission_page).to have_previous_question(:income_benefits, answer: :jobseekers_allowance)
  end

  #  Scenario: Display None of the above guidance information
  #  Given I am TOM
  #  And I am on the income benefits page
  #  When I select None of the above option
  #  Then None of the above option is highlighted
  #  And None of the above guidance Information displayed
  scenario 'Display None of the above guidance information' do
    # Arrange - Take tom to the benefits page
    given_i_am(:tom)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:none)

    # Assert
    # Note that we will not check the option is highlighted as we have just checked it, so it will be
    # this would effectively be testing the browser itself.
    expect(income_benefits_page.none_of_the_above_guidance).to be_visible
  end

  #   Scenario: Display Don't know guidance Information
  #   Given I am TOM
  #   And I am on the income benefits page
  #   When I select Don't know option
  #   Then Don't know option is highlighted
  #   And Don't know guidance Information displayed
  scenario "Display Don't know guidance Information" do
    # Arrange - Take tom to the benefits page
    given_i_am(:tom)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.choose(:dont_know)

    # Assert
    # Note that we will not check the option is highlighted as we have just checked it, so it will be
    # this would effectively be testing the browser itself.
    expect(income_benefits_page.dont_know_guidance).to be_visible
  end

  # Scenario: No option selected - no entry (Revised)
  #
  #   Given I am TOM
  #
  #   And I am on the income benefits page
  #
  #   When no option is selected
  #
  #   And I click  on the Next step button
  #
  #   Then I should see an error message
  #
  #   Error Message: "Select whether you're receiving one of the benefits listed"
  scenario 'No option selected' do
    # Arrange - Take tom to the benefits page
    given_i_am(:tom)
    answer_up_to(:benefits)

    # Act
    income_benefits_page.next

    # Assert
    expect(income_benefits_page.benefits).to have_error_nothing_selected
  end
end
