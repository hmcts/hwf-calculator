require 'rails_helper'
RSpec.describe 'Start calculator session', type: :feature, js: true do
  let(:start_page) { Calculator::Test::StartPage.new }
  let(:marital_status_page) { Calculator::Test::MaritalStatusPage.new }

  it 'progresses from home page to the first question' do
    start_calculator_session
    expect(marital_status_page).to be_displayed
  end

  it 'recovers from an expired session' do
    load_start_page
    start_page.wait_for_start_button

    start_page.delete_all_cookies
    start_page.start_session
    expect(marital_status_page).to be_all_there
  end
end
