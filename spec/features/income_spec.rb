require 'rails_helper'
# This feature represents the acceptance criteria defined in RST-670
RSpec.describe 'Income Test', type: :feature, js: true do
  include Calculator::Test::Pages
  include ActiveSupport::NumberHelper
  # Feature:  Income Test
  #
  # - It is based on household gross monthly income
  # - Citizen household gross monthly income is the money they get every month before any tax or National Insurance payments have been deducted
  # - HwF Calculator will execute Gross Monthly Income Test to check citizen eligibility for fee remission
  # - Income test is carried out on citizens that are not eligible for fee exemption and require help with fee
  # - On completion of income test citizen may receive part remission, full remission or no remission, depending on the sliding scale of income, partner status and number of children they may have

  # Rules:
  #
  # - For every £10 of gross monthly income received above the threshold, citizen must pay £5 towards the fee
  # - For Part remission, the figure is rounded down to the nearest £10
  # - Income test is subject to Citizen passing the Disposable Capital test
  # - Citizen may be eligible for full remission if their monthly income is less than the minimum threshold (Single:£1,085 & Couple: £1,245) plus £245 for each child that they have
  # - Citizen may be eligible for part remission if their monthly income is more than the minimum threshold (see above minimum threshold amount) but less than the maximum threshold (Single:£5,085 & Couple: £5,245) plus £245 for each child that they have
  # - Citizen will not be eligible for fee remission and will be required to pay the full court or tribunal fee if their monthly income is over the maximum threshold (see above maximum threshold amount)
  #
  # Personas
  #
  #   JOHN is a single, 56 year old man with 1 child. He is not on any benefit. He has £2,990 worth of capital and an income of £1,330. He has a court fee of £600
  #   ALLI is a married, 60 year old man with 1 child. He is not on any benefit. He has £3,800 worth of capital and an income of £1,489. He has a court fee of £1,334
  #   OLIVER is a married, 75 year old man with 4 children. He is not on income benefit. He has £15,000 worth of capital and an income of £5,735. He has a court fee of £20,000
  #   JAMES is a single, 45 year old man with 0 children. He is not on income benefit. He has £4,999 worth of capital and an income of £1,084. He has a court fee of £1,664
  #   THOMAS is a married, 50 year old man with 0 children. He is not on income benefit. He has £5,850 worth of capital and an income of £1,245. He has a court fee of £2,000
  #   RILEY is a married, 60 year old man with 2 children. He is not on income benefit. He has £6,850 worth of capital and an income of £1,730. He has a court fee of £2,330
  #   JACOB is a single, 35 year old man with 2 children. He is not on income benefit. He has £7,999 worth of capital and an income of £1,574. He has a court fee of £4,000
  #   LANDON is a married, 50 year old man with 0 children. He is not on income benefit. He has £9,600 worth of capital and an income of £5,244. He has a court fee of £4,900
  #   JOHN2 is a single, 60 year old man with 0 children. He is not on income benefit. He has £11,850 worth of capital and an income of £5,084. He has a court fee of £6,000
  #   JO is a married, 45 year old woman with 1 child. She is not on income benefit. He has £13,900 worth of capital and an income of £5,489. He has a court fee of £7,000
  #   SIMON is a single, 44 year old man with 1 child. He is not on income benefit. He has £13,999 worth of capital and an income of £5,330. He has a court fee of £6,999
  #   KEVIN is a single, 54 year old man with 2 children. He is not on income benefit. He has £15,800 worth of capital and an income of £5,575. He has a court fee of £10,000
  #   JOSEPH is a single, 35 year old man with 2 children. He is not on income benefit. He has £13,999 worth of capital and an income of £8,000. He has a court fee of £7,000
  #   TONIA is a married, 45 year old woman with 7 children. He is not on income benefit. He has £6,950 worth of capital and an income of £5,734. He has a court fee of £2,330
  #   MARYANN is a married, 50 year old woman with 10 children. He is not on income benefit. He has £9,800 worth of capital and an income of £1,734. He has a court fee of £5,000
  #   BETHANY is a single, 50 year old woman with no children. He is not on any benefit. He has £3,500 worth of capital and an income of £1,085. He has a court fee of £1,200
  #   BRITNEY is a married, 45 year old woman with no children. He is not on any benefit. He has £9,000 worth of capital and an income of £1,245. He has a court fee of £4,900
  #   ANGELA is a married, 30 year old woman with no children. He is not on any benefit. He has £5,500 worth of capital and an income of £5,244. He has a court fee of £1,800
  #   EDEN is a single, 40 year old woman with no children. He is not on any benefit. He has £4,900 worth of capital and an income of £5,085. He has a court fee of £1,665
  #   HOLLY is a married, 55 year old woman with no children. He is not on any benefit. He has £11,999 worth of capital and an income of £5,245. He has a court fee of £6,000
  #   THERESA is a single, 47 year old woman with no children. He is not on any benefit. He has £15,999 worth of capital and an income of £5,086. He has a court fee of £7,500
  #   TIANA is a married, 60 year old woman with no children. He is not on any benefit. He has £7,980 worth of capital and an income of £5,246. He has a court fee of £4,000

  # Messaging
  #
  #   Positive (likely to get help with fees - Full Remission)
  #
  #   - You should be eligible for a full remission
  #   - For single citizen: As you have stated you have an income of £XXX, you won't have to pay any of your stated £XXXX fee and will receive a full remission or refund if you have paid the fee within the last 3 months
  #   - For Couple: As you and your partner have stated you have a combined monthly income of £XXX, you won't have to pay any of your stated £XXXX fee and will receive a full remission or refund if you have paid the fee within the last 3 months
  #
  #   Positive (likely to get help with fees - Part Remission)
  #
  #   - You should be eligible for a Partial Remission
  #   - For single citizen: As you have stated you have a combined monthly income  £XXX, you would need to contribute £XXX of your stated £XXX fee or would receive a partial refund of £XXX if you have paid the full fee within the last 3 months
  #   - For Couple: As you and your partner have stated you have a combined monthly income  £XXX, you would need to contribute £XXX of your stated £XXX fee or would receive a partial refund of £XXX if you have paid the full fee within the last 3 months
  #
  #   Negative (unlikely to get help with fees - Not Eligible)
  #   - You're unlikely to get help with your fee
  #   - With a fee of £XXX and combined monthly income of £XXX, it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship (see guide)
  #
  # Scenarios
  #
  # Scenario: Income test for single citizen with minimum income threshold (0 Remission)
  #   Given I am JOHN
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  scenario 'Income test for single citizen (john) with minimum income threshold (full Remission)' do
    # Arrange
    given_i_am(:john)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end
  #
  # Scenario: Income test for married citizen with minimum income threshold
  #   Given I am ALLI
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for married citizen (alli) with minimum income threshold (full remission)' do
    # Arrange
    given_i_am(:alli)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end
  # Scenario: Income test for married citizen with maximum income threshold
  #   Given I am OLIVER
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission (1750)
  #
  scenario 'Income test for married citizen (oliver) with maximum income threshold (partial remission)' do
    # Arrange
    given_i_am(:oliver)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_valid_for_final_partial_message(user, remission: 1750)
  end

  # Scenario: Income test for single citizen with minimum income threshold (0 Remission)
  #   Given I am JAMES
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for single citizen (james) with minimum income threshold (full Remission)' do
    # Arrange
    given_i_am(:james)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for married citizen with minimum income threshold (0 Remission)
  #   Given I am THOMAS
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  scenario 'Income test for married citizen (thomas) with minimum income threshold (full Remission)' do
    # Arrange
    given_i_am(:thomas)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for married citizen with minimum income threshold
  #   Given I am RILEY
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for married citizen (riley) with minimum income threshold (full remission)' do
    # Arrange
    given_i_am(:riley)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for single citizen with minimum income threshold
  #   Given I am JACOB
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for single citizen (jacob) with minimum income threshold (full remission)' do
    # Arrange
    given_i_am(:jacob)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for married citizen with maximum income threshold
  #   Given I am LANDON
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for married citizen (landon) with maximum income threshold (partial remission)' do
    # Arrange
    #   LANDON is a married, 50 year old man with 0 children. He is not on income benefit. He has £9,600 worth of capital and an income of £5,244. He has a court fee of £4,900
    # his min limit is 1245, his earnings are 3999 over this, so the remission is 1990
  given_i_am(:landon)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_valid_for_final_partial_message(user, remission: 1990)
  end

  # Scenario: Income test for single citizen with maximum income threshold
  #   Given I am JOHN
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for single citizen (john2) with maximum income threshold (partial remission)' do
    # Arrange
    #   JOHN2 is a single, 60 year old man with 0 children. He is not on income benefit. He has £11,850 worth of capital and an income of £5,084. He has a court fee of £6,000
    # his limit is 1085 so his income is 3999 over
    # Therefore the remission is 1990
    given_i_am(:john2)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_valid_for_final_partial_message(user, remission: 1990)
  end

  # Scenario: Income test for married citizen with maximum income threshold
  #   Given I am JO
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for married citizen (jo) with maximum income threshold (partial remission)' do
    # Arrange - Jo is Married, Age 45, 13900 Disposable capital, 5489 Monthly income, 1 child and no benefits
    given_i_am(:jo)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end

  # Scenario: Income test for single citizen with maximum income threshold
  #   Given I am SIMON
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for single citizen (simon) with maximum income threshold (partial remission)' do
    # Arrange
    given_i_am(:simon)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end

  # Scenario: Income test for single citizen with maximum income threshold
  #   Given I am KEVIN
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for single citizen (kevin) with maximum income threshold (partial remission)' do
    # Arrange
    given_i_am(:kevin)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end

  # Scenario: Income test for single citizen over maximum income threshold
  #   Given I am JOSEPH
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am not eligible for fee remission
  #
  scenario 'Income test for single citizen (joseph) over maximum income threshold (no remission)' do
    # Arrange
    given_i_am(:joseph)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to be_displayed
  end

  # Scenario: Income test for married citizen with maximum income threshold and many children
  #   Given I am TONIA
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for married citizen (tonia) with maximum income threshold and many children (partial remission)' do
    # Arrange
    given_i_am(:tonia)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end

  # Scenario: Income test for single citizen with minimum income threshold and many children
  #   Given I am MARYANN
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  scenario 'Income test for single citizen (maryann) with minimum income threshold and many children (full remission)' do
    # Arrange
    given_i_am(:maryann)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for single citizen with minimum income threshold and no children
  #   Given I am BETHANY
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for single citizen with minimum income threshold and no children' do
    # Arrange
    given_i_am(:bethany)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end
  # Scenario: Income test for married citizen with minimum income threshold and no children
  #   Given I am BRITNEY
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for full remission
  #
  scenario 'Income test for married citizen with minimum income threshold and no children' do
    # Arrange
    given_i_am(:britney)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to be_valid_for_final_positive_message(user)
  end

  # Scenario: Income test for married citizen with maximum income threshold and no children
  #   Given I am ANGELA
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for married citizen with maximum income threshold and no children' do
    # Arrange
    given_i_am(:angela)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end

  # Scenario: Income test for single citizen with maximum income threshold and no children
  #   Given I am EDEN
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for single citizen with maximum income threshold and no children' do
    # Arrange
    given_i_am(:eden)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end
  # Scenario: Income test for married citizen with maximum income threshold and no children
  #   Given I am HOLLY (Married, 55, Capital 11999, Fee 6000, children 0, benefits none, income 5245 )
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am eligible for partial remission
  #
  scenario 'Income test for married citizen with maximum income threshold and no children' do
    # Arrange
    given_i_am(:holly)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(partial_remission_page).to be_displayed
  end
  # Scenario: Income test for single citizen with over maximum income threshold and no children
  #   Given I am THERESA
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am not eligible for fee remission
  #
  scenario 'Income test for single citizen with over maximum income threshold and no children' do
    # Arrange
    given_i_am(:theresa)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to be_displayed
  end

  # Scenario: Income test for married citizen with over maximum income threshold and no children
  #   Given I am TIANA
  #   AND I am on the total income page
  #   When I click on the Next step button
  #   Then I should see that I am not eligible for fee remission  
  scenario 'Income test for married citizen with over maximum income threshold and no children' do
    # Arrange
    given_i_am(:tiana)
    answer_questions_up_to_total_income

    # Act
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to be_displayed
  end
end
