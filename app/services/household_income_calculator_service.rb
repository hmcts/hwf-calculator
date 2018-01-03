# A calculator service for the household income for an individual or couple
#
# @TODO This is a placeholder for the code - needs implementation
class HouseholdIncomeCalculatorService < BaseCalculatorService
  MY_FIELDS = [:number_of_children].freeze

  def valid?
    true
  end

  def call
    self
  end

  def self.fields_required(inputs, previous_calculations:)
    if previous_calculations.dig(:benefits_received_calculator_service, :help_available)
      []
    else
      MY_FIELDS - inputs.keys
    end
  end
end
