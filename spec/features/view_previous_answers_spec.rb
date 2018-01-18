require 'rails_helper'
# This feature represents adds to the acceptance criteria defined in RST-745
RSpec.describe 'Change previous answers test', type: :feature, js: true do
  scenario 'Citizen on marital status page should not see any previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:marital_status)

    # Assert
    expect(marital_status_page).to have_no_previous_answers
  end

  scenario 'Citizen on fees page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:court_fee)

    # Assert
    expect(court_fee_page.previous_answers).to have_marital_status.
      and(have_no_court_fee).
      and(have_no_date_of_birth).
      and(have_no_disposable_capital).
      and(have_no_income_benefits).
      and(have_no_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on date of birth page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:date_of_birth)

    # Assert
    expect(date_of_birth_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_no_date_of_birth).
      and(have_no_disposable_capital).
      and(have_no_income_benefits).
      and(have_no_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on disposable capital page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:disposable_capital)

    # Assert
    expect(disposable_capital_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_no_disposable_capital).
      and(have_no_income_benefits).
      and(have_no_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on income benefits page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:benefits)

    # Assert
    expect(income_benefits_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_no_income_benefits).
      and(have_no_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on number of children page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:number_of_children)

    # Assert
    expect(number_of_children_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_income_benefits).
      and(have_no_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on total income page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:total_income)

    # Assert
    expect(total_income_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_income_benefits).
      and(have_number_of_children).
      and(have_no_total_income)
  end

  scenario 'Citizen on positive result page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_all_questions

    # Assert
    expect(full_remission_page).to be_displayed
    expect(full_remission_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_income_benefits).
      and(have_number_of_children).
      and(have_total_income)
  end

  scenario 'Citizen on negative result page should see correct previous questions' do
    # Arrange
    given_i_am(:joseph)

    # Act
    answer_all_questions

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_income_benefits).
      and(have_number_of_children).
      and(have_total_income)
  end

  scenario 'Citizen on partial remission result page should see correct previous questions' do
    # Arrange
    given_i_am(:oliver)

    # Act
    answer_all_questions

    # Assert
    expect(partial_remission_page).to be_displayed
    expect(partial_remission_page.previous_answers).to have_marital_status.
      and(have_court_fee).
      and(have_date_of_birth).
      and(have_disposable_capital).
      and(have_income_benefits).
      and(have_number_of_children).
      and(have_total_income)
  end
end