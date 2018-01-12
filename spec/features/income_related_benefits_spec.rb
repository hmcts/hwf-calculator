require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-677
RSpec.describe 'Income Benefit Page Content', type: :feature, js: true do
  include Calculator::Test::Pages
  # The next page is always the number of children
  let(:next_page) { Calculator::Test::En::NumberOfChildrenPage.new }

  # Scenario: Disable non-income benefit options
  #   Given I am JOHN
  #   And I am on the income benefits page
  #   When I select one or more income related benefit options
  #   Then the None of the above option is disabled
  #   And the Don't know option disabled
  scenario 'Disable none income benefit options' do
    # Arrange - Get john to the benefits page
    benefits_to_select = [
      messaging.t('hwf_pages.income_benefits.labels.benefits.jobseekers_allowance'),
      messaging.t('hwf_pages.income_benefits.labels.benefits.pension_credit')
    ]
    given_i_am(:john)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.benefits.set(benefits_to_select)

    # Assert
    expect(income_benefits_page.none_of_the_above_option).to be_disabled
  end

  scenario 'Disable none income benefit options - dont know option' do
    # Arrange - Get john to the benefits page
    benefits_to_select = [
      messaging.t('hwf_pages.income_benefits.labels.benefits.jobseekers_allowance'),
      messaging.t('hwf_pages.income_benefits.labels.benefits.pension_credit')
    ]
    given_i_am(:john)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.benefits.set(benefits_to_select)

    # Assert
    expect(income_benefits_page.dont_know_option).to be_disabled
  end

  # Scenario: Select None of the Above option
  # Given I am ALLI
  # And I am on the income benefits page
  # And I select None of the above
  # When I click on the Next step button
  # Then I should see the next question
  scenario 'Select None of the Above option' do
    # Arrange - Take alli to the benefits page
    given_i_am(:alli)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.choose_none
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
  scenario 'Select income related benefit option' do
    # Arrange - Take oliver to the benefits page
    given_i_am(:oliver)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.benefits.set([messaging.t('hwf_pages.income_benefits.labels.benefits.jobseekers_allowance')])
    income_benefits_page.next

    # Assert
    expect(full_remission_page).to be_displayed
  end

  scenario 'Select income related benefit option - answer added to previous answers' do
    # Arrange - Take oliver to the benefits page
    given_i_am(:oliver)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.benefits.set([messaging.t('hwf_pages.income_benefits.labels.benefits.jobseekers_allowance')])
    income_benefits_page.next

    # Assert
    expect(full_remission_page.previous_answers.income_benefits.answer.text).to eql messaging.t('hwf_pages.income_benefits.previous_questions.benefits_received.jobseekers_allowance')
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
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.choose_none

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
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.choose_dont_know

    # Assert
    # Note that we will not check the option is highlighted as we have just checked it, so it will be
    # this would effectively be testing the browser itself.
    expect(income_benefits_page.dont_know_guidance).to be_visible
  end

  #   Scenario: No option selected
  #
  #   Given I am TOM
  #
  #   And I am on the income benefits page
  #
  #   When no option is selected
  #
  #   And I click  on the Next step button
  #
  #   Then I see an error message
  #
  #   And I am prompted to select an option to continue
  scenario 'No option selected' do
    # Arrange - Take tom to the benefits page
    given_i_am(:tom)
    answer_questions_up_to_benefits

    # Act
    income_benefits_page.next

    # Assert
    expect(income_benefits_page.error_nothing_selected).to be_visible
  end
end
