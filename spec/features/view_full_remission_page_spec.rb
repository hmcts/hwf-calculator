require 'rails_helper'
RSpec.describe 'View full remission page', type: :feature, js: true do
  scenario 'Verify no caching on full remission page using NON JS BROWSER', js: false do
    # Arrange
    given_i_am(:john)
    answer_up_to(:total_income)

    # Act
    answer_total_income_question

    # Assert
    expect(full_remission_page).to have_no_cache
  end
end
