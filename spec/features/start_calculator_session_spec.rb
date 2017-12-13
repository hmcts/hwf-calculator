require 'rails_helper'
RSpec.describe 'Start calculator session', type: :feature do
  let(:start_page) { CalculatorFrontEnd::Test::En::StartPage.new }
  it 'progresses from home page to the first question as suggested by the API' do
    stub_request(:post, 'http://calculator.com:4100/api/calculator/calculation')
    start_page.load_page
    start_page.start_session
  end
end