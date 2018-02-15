require 'rails_helper'
RSpec.describe 'Start calculator session', type: :feature do
  let(:start_page) { Calculator::Test::StartPage.new }
  let(:marital_status_page) { Calculator::Test::MaritalStatusPage.new }

  it 'progresses from home page to the first question' do
    start_calculator_session
    expect(marital_status_page).to be_displayed
  end
end
