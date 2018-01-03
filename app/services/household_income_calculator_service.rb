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

  # @TODO Review the method below - see details in RST-733, but allow for now
  def self.fields_required(inputs, previous_calculations:)
    if previous_calculations.dig(:benefits_received, :help_available)
      []
    else
      MY_FIELDS - inputs.keys
    end
  end
end
