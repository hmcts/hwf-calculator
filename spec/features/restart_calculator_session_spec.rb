require 'rails_helper'
RSpec.describe 'Re start calculator session', type: :feature, js: true do
  let(:start_page) { Calculator::Test::StartPage.new }
  let(:marital_status_page) { Calculator::Test::MaritalStatusPage.new }

  it 'progresses from home page to the first question after a restart' do
    # Arrange - John can take us all the way through to the end then hit the back button
    given_i_am :john
    answer_up_to :total_income
    answer_total_income_question
    full_remission_page.wait_for_next_steps
    full_remission_page.back_via_browser_button
    start_page.wait_for_start_button

    # Act - Start the session with the start button
    start_page.start_session

    # Assert - The marital status page should be present
    expect(marital_status_page).to be_displayed.and(be_all_there)
  end
end
