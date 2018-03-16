require 'rails_helper'
RSpec.describe 'View not eligible page' do
  scenario 'Verify no caching on not eligible page using NON JS BROWSER', js: false do
    # Arrange
    given_i_am(:joseph)
    answer_up_to(:total_income)

    # Act
    answer_total_income_question

    # Assert
    expect(not_eligible_page).to have_no_cache
  end
end
