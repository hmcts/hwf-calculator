require 'rails_helper'
RSpec.describe 'View not eligible page', type: :feature, js: true do
  scenario 'Verify no caching on not eligible page using NON JS BROWSER', js: false do
    # Arrange
    given_i_am(:joseph)
    answer_up_to(:total_income)

    # Act
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to have_no_cache
  end

  scenario 'Verify exceptional hardship link' do
    # Arrange
    given_i_am(:joseph)
    answer_up_to :total_income
    answer_total_income_question

    # Act
    not_eligible_page.open_exceptional_hardship

    # Assert
    aggregate_failures 'Validate all' do
      expect(exceptional_hardship_page).to be_displayed
      expect(exceptional_hardship_page).to have_page_header
      expect(exceptional_hardship_page).to be_all_there
    end
  end

  scenario 'Verify the user can return to the same place from the exceptional hardship link' do
    # Arrange
    given_i_am(:joseph)
    answer_up_to :total_income
    answer_total_income_question
    not_eligible_page.open_exceptional_hardship

    # Act
    exceptional_hardship_page.back

    # Assert
    aggregate_failures 'Validate all' do
      expect(not_eligible_page).to be_displayed
      expect(not_eligible_page).to be_valid_for_final_negative_message(user)
    end
  end
end
