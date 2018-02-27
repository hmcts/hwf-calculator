# The primary interface for the calculator
#
# This class is used with sanitized data in the form of a hash
#
# @example Example usage for a complete calculation with no further info needed:
#   inputs = {
#     marital_status: 'single',
#     fee: 1000.0,
#     date_of_birth: Date.parse('1 December 2000'),
#     disposable_capital: 10000.0,
#     benefits_received: [],
#     number_of_children: 2,
#     total_income: 10000.0
#   }
#   service = CalculationService.call(inputs)
#   service.help_not_available? # => true
#   service.help_available? # => false
#   service.messages # => [{ key: :likely, source: :disposable_capital }]
#
# @example Example usage for a partial calculation with more fields to fill in
#   inputs = {
#     marital_status: 'single',
#     fee: 1000.0,
#   }
#   service = CalculationService.call(inputs)
#   service.help_not_available? # => false
#   service.help_available? # => false
#   service.messages # => [{ key: :likely, source: :disposable_capital }]
#
# The second example shows that there is not a definitive answer yet,
# This allows the front end to inform the user upon a partial success that it depends
# on them providing the listed fields.
#
class CalculationService
  MY_FIELDS = [:marital_status].freeze
  DEFAULT_CALCULATORS = [
    'DisposableCapital',
    'BenefitsReceived',
    'HouseholdIncome'
  ].freeze

  # Create an instance of CalculationService
  # @param [Hash] inputs
  # @param [Array<BaseCalculatorService>] calculators A list of calculators to use.
  #  This is optional, normally for testing.
  # @return [CalculationService] This instance
  def initialize(inputs, calculation, calculators: default_calculators)
    self.inputs = inputs
    calculation.merge_inputs(inputs)
    self.calculation = calculation
    self.calculators = calculators
  end

  # Performs the calculation with the given inputs and configured calculators
  #
  # @param [Hash] inputs
  # @param [Array<BaseCalculatorService>] calculators A list of calculators to use.
  #  This is optional, normally for testing.
  # @return [CalculationService] A newly created instance of this class
  def self.call(*args)
    new(*args).call
  end

  # Performs the calculation with the stored inputs and configured calculators
  #
  # @return [CalculationService] This instance - with the results available using other instance methods
  def call
    catch(:abort) do
      calculators.each do |calculator|
        my_result = catch(:invalid_inputs) do
          perform_calculation_using(calculator)
        end
        throw :abort, self if my_result.final_decision? || !my_result.valid?
      end
    end
    self
  end

  def result
    calculation
  end

  private

  def default_calculators
    DEFAULT_CALCULATORS.map { |c| "#{c}CalculatorService".constantize }
  end

  def perform_calculation_using(calculator)
    result = calculator.call(calculation.inputs)
    post_process_failure result, calculator
    post_process_undecided result, calculator
    post_process_success result, calculator
    result
  end

  def post_process_failure(result, calculator)
    if result.available_help == :none
      add_failure(result, identifier: calculator.identifier)
      throw(:abort)
    end
  end

  def post_process_undecided(result, _calculator)
    if result.available_help == :undecided
      add_undecided(result)
    end
  end

  def post_process_success(result, calculator)
    if [:full, :partial].include? result.available_help
      add_success(result, identifier: calculator.identifier)
    end
  end

  def add_undecided(result)
    calculation.available_help = :undecided
    calculation.messages.concat result.messages
  end

  def add_failure(result, identifier:)
    calculation.available_help = :none
    calculation.final_decision_by = identifier if result.final_decision?
    calculation.messages.concat result.messages
  end

  def add_success(result, identifier:)
    calculation.available_help = result.available_help
    calculation.final_decision_by = identifier if result.final_decision?
    # The remission is always from the last value given,
    # so its ok to overwrite this
    calculation.remission = result.remission
    calculation.messages.concat result.messages
  end

  attr_accessor :calculators, :calculation, :inputs
end
