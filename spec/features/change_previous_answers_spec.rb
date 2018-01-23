require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-745
# @TODO This feature is not 100% as per AC at the moment as I am questioning the resetting of previous questions - just the last step in every scenario
RSpec.describe 'Change previous answers test', type: :feature, js: true do
  # Feature: Change Previous Answer
  #
  # Ability to Change Previous Answer of Choice in the calculator
  #
  #
  # Rules:
  #
  # User should be able to update previous answers at any point in the calculator session however, the feature should be excluded from the calculator landing page and the Partner Status page
  # When an answer to a question is updated, calculation should be revalidated and corresponding response displayed
  # After user goes back to a question and make changes to their answer, direct users back to the question they were at before they went back. If we cannot because the new answer has changed the calculation and the question is no longer valid then we surface the next answer in the chain for the user to review
  # Design Assumptions:
  #
  # User unable to make updates to previous answers when they fail disposable capital test (Validated)
  # User unable to make updates to previous answers in the income test response page (Validated)
  # Personas:
  #
  # JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  # ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  # LOLA is a married, 90 year old woman with £19,000 worth of capital. She has a court fee of £100,000
  # THERESA is a single, 47 year old woman with no children. She has £15,999 worth of capital and an income of £5,086. He has a court fee of £7,500
  # Scenario: Citizen update Partner status from court or tribunal fee page
  #               Given I am JOHN
  #               And I am on the court or tribunal fee page
  #               When I click on the Change link for the Status question
  #               Then I should see the Status question prepopulated with previous answer
  #               And the Previous answers section should disappear
  scenario 'Citizen update Partner status from court or tribunal fee page' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:court_fee)

    # Act
    court_fee_page.go_back_to_question(:marital_status)

    # Assert
    expect(marital_status_page).to be_displayed
  end
  #
  # Scenario: Citizen update Partner status from Number of Children page
  #               Given I am JOHN
  #               And I am on the Number of Children page
  #               When I click on the Change link for the Status question
  #               Then I should see the Status question prepopulated with previous answer
  #               And relevant Previous answers information should be retained
  #
  scenario 'Citizen update Partner status from Number of Children page' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:number_of_children)

    # Act
    number_of_children_page.go_back_to_question(:marital_status)

    # Assert
    expect(marital_status_page).to be_displayed.and(have_previous_answers)
  end

  # Scenario: Citizen update Savings and investment amount from Number of Children page
  #               Given I am ALLI
  #               And I am on the Number of Children page
  #               When I click on the Change link for the Savings and investment question
  #               Then I should see the Savings and investment question prepopulated with previous answer
  #               And relevant Previous answers information should be retained
  #
  scenario 'Citizen update Savings and investment amount from Number of Children page' do
    # Arrange
    given_i_am(:alli)
    answer_up_to(:number_of_children)

    # Act
    number_of_children_page.go_back_to_question(:disposable_capital)

    # Assert
    expect(disposable_capital_page).to be_displayed.and(have_previous_answers)
  end

  # Scenario: Citizen update Savings and investment amount from the Benefit response page
  #               Given I am JOHN
  #               And I am on the Benefit response page
  #               When I click on the Change link for the Savings and investment question
  #               Then I should see the Savings and investment question prepopulated with previous answer
  #               And relevant Previous answers information should be retained
  #
  scenario 'Citizen update Savings and investment amount from the Benefit response page' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:benefits)

    # Act
    court_fee_page.go_back_to_question(:disposable_capital)

    # Assert
    expect(disposable_capital_page).to be_displayed.and(have_previous_answers)
  end

  # Scenario: Citizen update Court or tribunal fee from the Total Income page
  #               Given I am JOHN
  #               And I am on the Total Income page
  #               When I click on the Change link for the Court or tribunal fee question
  #               Then I should see the Court or tribunal fee question prepopulated with previous answer
  #               And relevant Previous answers information should be retained
  #
  scenario 'Citizen update Court or tribunal fee from the Total Income page' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.go_back_to_question(:court_fee)

    # Assert
    expect(court_fee_page).to be_displayed.and(have_previous_answers)
  end

  # Scenario: Citizen update income benefit from the Total Income page
  #               Given I am JOHN
  #               And I am on the Total Income page
  #               When I click on the Change link for the income benefit question
  #               Then I should see the income benefit question prepopulated with previous answer
  #               And relevant Previous answers information should be retained
  #
  scenario 'Citizen update income benefit from the Total Income page' do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    total_income_page.go_back_to_question(:income_benefits)

    # Assert
    expect(income_benefits_page).to be_displayed.and(have_previous_answers)
  end

  # Scenario: Citizen unable to make updates from the Total income response page
  #                Given I am THERESA
  #               When I navigate to the Income test response page
  #               Then I should see previous answers Change links disabled
  #
  #
  scenario 'Citizen unable to make updates from the Total income response page' do
    # Arrange
    given_i_am(:theresa)

    # Act
    answer_all_questions

    # Assert
    expect(full_remission_page.previous_answers).to be_disabled
  end

  # Scenario: Citizen unable to make updates from the disposable Capital test response page
  #                Given I am LOLA
  #               When I navigate to the disposable Capital test response page
  #               Then I should see previous answers Change links disabled
  scenario 'Citizen unable to make updates from the disposable Capital test response page' do
    # Arrange
    given_i_am(:lola)

    # Act
    answer_up_to(:benefits)

    # Assert
    aggregate_failures 'Validating previous answers up to benefits' do
      not_eligible_page.previous_answers.tap do |a|
        expect(a.marital_status).to be_disabled
        expect(a.court_fee).to be_disabled
        expect(a.date_of_birth).to be_disabled
        expect(a.disposable_capital).to be_disabled
        expect(a).to have_no_income_benefits.
            and(have_no_number_of_children).
            and(have_no_total_income)
      end
    end
  end

  scenario 'Citizen changes their fee to push them over the disposable capital limit' do
    # Arrange - Thomas has a fee of 2000 with a disposable capital of 5850 which will pass disposable capital
    given_i_am(:thomas)
    answer_up_to(:total_income)
    total_income_page.previous_answers.court_fee.navigate_to

    # Act
    court_fee_page.fee.set(1000)
    court_fee_page.next

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.court_fee.answer(text: "£1,000")).to be_present
  end

  scenario 'Citizen changes their DOB to push them over the disposable capital limit' do
    # Arrange - Tom is 80, with a fee of 100 and disposable income of 15999.
    # So, by default he will fly through the disposable capital test, but when he
    # corrects his age to 60 - it will mean he fails it.
    #
    given_i_am(:tom)
    dob = (Time.zone.today - 60.years).strftime('%d/%m/%Y')
    answer_up_to(:total_income)
    total_income_page.previous_answers.date_of_birth.navigate_to

    # Act
    date_of_birth_page.date_of_birth.set(dob)
    date_of_birth_page.next

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.date_of_birth.answer(text: dob)).to be_present
  end

  scenario 'Citizen who is married changes own DOB to push them over the disposable capital limit' do
    # Arrange - sue has been setup for this test - both her and her partner are over 61
    # which means that the 11,000 disposable income is lower than the 16000 threshold for
    # over 61's so the disposable capital test will pass -
    # but when she remembers that she is really 60, then this means they are classed as 'under 61' so the
    # limit is 10,000 which she will be over and should fail
    given_i_am(:sue)
    dob = (Time.zone.today - 60.years).strftime('%d/%m/%Y')
    answer_up_to(:total_income)
    total_income_page.previous_answers.date_of_birth.navigate_to

    # Act
    date_of_birth_page.date_of_birth.set(dob)
    date_of_birth_page.next

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.date_of_birth.answer(text: dob)).to be_present
  end

  scenario 'Citizen who is married changes partners DOB to push them over the disposable capital limit' do
    # Arrange - sue has been setup for this test - both her and her partner are over 61
    # which means that the 11,000 disposable income is lower than the 16000 threshold for
    # over 61's so the disposable capital test will pass -
    # but when she remembers that her partner is really 60, then this means they are classed as 'under 61' so the
    # limit is 10,000 which she will be over and should fail
    given_i_am(:sue)
    dob = (Time.zone.today - 60.years).strftime('%d/%m/%Y')
    answer_up_to(:total_income)
    total_income_page.previous_answers.partner_date_of_birth.navigate_to

    # Act
    date_of_birth_page.partner_date_of_birth.set(dob)
    date_of_birth_page.next

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.partner_date_of_birth.answer(text: dob)).to be_present
  end

  scenario 'Citizen changes disposable income to push them over the disposable capital limit' do

  end

  scenario 'Citizen not on benefits gets to last question and states they are on benefits' do
    # Arrange - We will use john for this who would normally pass the disposable capital test
    # as he has a fee of 600 and disposable capital of 2990.  The limit is 3000 so we will
    # modify that to push him over the limit.
    given_i_am(:john)
    answer_up_to(:total_income)
    total_income_page.previous_answers.disposable_capital.navigate_to

    # Act
    disposable_capital_page.disposable_capital.set('3001')
    disposable_capital_page.next

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.disposable_capital.answer(text: '3,001')).to be_present
  end

  scenario 'Citizen who normally gets partial remission gets a different amount if they change the number of children from the last page' do
    # Arrange - We will use oliver for this who would normally pass the disposable capital test and get partial remittance
    given_i_am(:oliver)
    answer_up_to(:total_income)
    total_income_page.previous_answers.number_of_children.navigate_to

    # Act
    number_of_children_page.number_of_children.set('1')
    number_of_children_page.next
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to be_displayed
    expect(not_eligible_page.previous_answers.number_of_children.answer(text: '1')).to be_present
  end
end
