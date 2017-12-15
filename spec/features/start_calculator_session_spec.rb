require 'rails_helper'
RSpec.describe 'Start calculator session', type: :feature do
  let(:start_page) { Calculator::Test::En::StartPage.new }
  let(:marital_status_page) { Calculator::Test::En::MaritalStatusPage.new }
  it 'progresses from home page to the first question as suggested by the API' do
    start_page.load_page
    start_page.start_session
    expect(marital_status_page).to be_displayed
  end
end
