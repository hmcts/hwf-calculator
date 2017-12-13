require 'rails_helper'
RSpec.describe 'Start calculator session', type: :feature do
  let(:start_page) { CalculatorFrontEnd::Test::En::StartPage.new }
  let(:marital_status_page) { CalculatorFrontEnd::Test::En::MaritalStatusPage.new }
  let(:api_base_url) { Rails.application.config.api['base_url'] }
  it 'progresses from home page to the first question as suggested by the API' do
    response_json = {
      calculation: {
        inputs: {
          should_get_help: false,
          should_not_get_help: false,
          messages: []
        },
        result: {

        },
        fields_required: %i[
          marital_status
          fee
          date_of_birth
          total_savings
          benefits_received
          number_of_children
          total_income
        ],
        required_fields_affecting_likelyhood: []
      }
    }
    stub_request(:post, "#{api_base_url}/calculation").to_return body: response_json.to_json, status: 200, headers: { 'Content-Type' => 'application/json' }
    start_page.load_page
    start_page.start_session
    expect(marital_status_page).to be_displayed
  end
end
