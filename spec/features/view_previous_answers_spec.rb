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

  scenario 'Citizen (single) on fees page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:court_fee)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(court_fee_page.previous_answers).to have_no_court_fee.
        and(have_no_date_of_birth).
        and(have_no_disposable_capital).
        and(have_no_income_benefits).
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(court_fee_page.previous_answers.marital_status).to have_answered(user.marital_status)
    end
  end

  scenario 'Citizen (married) on fees page should see correct previous questions' do
    # Arrange
    given_i_am(:alli)

    # Act
    answer_up_to(:court_fee)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(court_fee_page.previous_answers).to have_no_court_fee.
        and(have_no_date_of_birth).
        and(have_no_disposable_capital).
        and(have_no_income_benefits).
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(court_fee_page.previous_answers.marital_status).to have_answered(user.marital_status)
    end
  end

  scenario 'Citizen on date of birth page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:date_of_birth)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(date_of_birth_page.previous_answers).to have_no_date_of_birth.
        and(have_no_disposable_capital).
        and(have_no_income_benefits).
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(date_of_birth_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(date_of_birth_page.previous_answers.court_fee).to have_answered(user.fee)
    end
  end

  scenario 'Citizen (single) on disposable capital page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:disposable_capital)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(disposable_capital_page.previous_answers).to have_no_disposable_capital.
        and(have_no_income_benefits).
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(disposable_capital_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(disposable_capital_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(disposable_capital_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
    end
  end

  scenario 'Citizen (married) on disposable capital page should see correct previous questions' do
    # Arrange
    given_i_am(:alli)

    # Act
    answer_up_to(:disposable_capital)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(disposable_capital_page.previous_answers).to have_no_disposable_capital.
        and(have_no_income_benefits).
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(disposable_capital_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(disposable_capital_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(disposable_capital_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(disposable_capital_page.previous_answers.partner_date_of_birth).to have_answered(user.partner_date_of_birth)
    end
  end

  scenario 'Citizen on income benefits page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:benefits)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(income_benefits_page.previous_answers).to have_no_income_benefits.
        and(have_no_number_of_children).
        and(have_no_total_income)
      expect(income_benefits_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(income_benefits_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(income_benefits_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(income_benefits_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
    end
  end

  scenario 'Citizen (no benefits) on number of children page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:number_of_children)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(number_of_children_page.previous_answers).to have_no_number_of_children.
        and(have_no_total_income)
      expect(number_of_children_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(number_of_children_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(number_of_children_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(number_of_children_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(number_of_children_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
    end
  end

  scenario 'Citizen (on benefits) on number of children page should see correct previous questions' do
    # Arrange
    given_i_am(:william)

    # Act
    answer_up_to(:number_of_children)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(full_remission_page.previous_answers).to have_no_number_of_children.
        and(have_no_total_income)
      expect(full_remission_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(full_remission_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(full_remission_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(full_remission_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(full_remission_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
    end
  end

  scenario 'Citizen on total income page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_up_to(:total_income)

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(total_income_page.previous_answers).to have_no_total_income
      expect(total_income_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(total_income_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(total_income_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(total_income_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(total_income_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
      expect(total_income_page.previous_answers.number_of_children).to have_answered(user.number_of_children)
    end
  end

  scenario 'Citizen on positive result page should see correct previous questions' do
    # Arrange
    given_i_am(:john)

    # Act
    answer_all_questions

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(full_remission_page).to be_displayed
      expect(full_remission_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(full_remission_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(full_remission_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(full_remission_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(full_remission_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
      expect(full_remission_page.previous_answers.number_of_children).to have_answered(user.number_of_children)
      expect(full_remission_page.previous_answers.total_income).to have_answered(user.total_income)
    end
  end

  scenario 'Citizen on negative result page should see correct previous questions' do
    # Arrange
    given_i_am(:joseph)

    # Act
    answer_all_questions

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(not_eligible_page).to be_displayed
      expect(not_eligible_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(not_eligible_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(not_eligible_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(not_eligible_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(not_eligible_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
      expect(not_eligible_page.previous_answers.number_of_children).to have_answered(user.number_of_children)
      expect(not_eligible_page.previous_answers.total_income).to have_answered(user.total_income)
    end
  end

  scenario 'Citizen on partial remission result page should see correct previous questions' do
    # Arrange
    given_i_am(:oliver)

    # Act
    answer_all_questions

    # Assert
    aggregate_failures 'Validating all answers' do
      expect(partial_remission_page).to be_displayed
      expect(partial_remission_page.previous_answers.marital_status).to have_answered(user.marital_status)
      expect(partial_remission_page.previous_answers.court_fee).to have_answered(user.fee)
      expect(partial_remission_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
      expect(partial_remission_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
      expect(partial_remission_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
      expect(partial_remission_page.previous_answers.number_of_children).to have_answered(user.number_of_children)
      expect(partial_remission_page.previous_answers.total_income).to have_answered(user.total_income)
    end
  end
end