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
#   service.fields_required # => []
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
#   service.fields_required # => [:date_of_birth, :disposable_capital, :benefits_received,
#                                 :number_of_children, :total_income]
#
# The second example shows that there is not a definitive answer yet,
# and further fields are required as specified in the correct order in 'fields_required'
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
  attr_reader :messages, :inputs, :available_help, :remission, :final_decision_by

  # Create an instance of CalculationService
  # @param [Hash] inputs
  # @param [Array<BaseCalculatorService>] calculators A list of calculators to use.
  #  This is optional, normally for testing.
  # @return [CalculationService] This instance
  def initialize(inputs, calculators: default_calculators)
    self.inputs = inputs.freeze
    self.available_help = :undecided
    self.final_decision_by = :none
    self.remission = 0.0
    self.messages = []
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

  # Provides a hash representation of the calculation result.
  #
  # @return [Hash] A hash (symbolized keys) representing the result
  def to_h
    {
      inputs: inputs,
      available_help: available_help,
      final_decision_by: final_decision_by,
      remission: remission,
      fields_required: fields_required,
      messages: messages
    }
  end

  # Indicates what fields are required to be filled in by the user - in the order the
  # questions should be asked.
  #
  # @return [Array<Symbol>] A list of fields represented by symbols that need to be filled in
  # possible values are :marital_status, :fee, :date_of_birth, :disposable_capital,
  # :benefits_received, :number_of_children, :total_income
  def fields_required
    @fields_required ||= begin
      required = calculators.map do |c|
        c.fields_required(inputs)
      end.flatten
      my_fields_required + required
    end
  end

  # Indicates if a calculator has made a final decision, preventing any further
  # calculations from being done.
  # This can be done by any calculator, but currently it is used by the
  # disposable capital calculator as it has the right to say - no more questions
  # this person has too much in savings.
  # @return [Boolean] Indicates if a final decision has been
  def final_decision_made?
    final_decision_by != :none
  end

  private

  def default_calculators
    DEFAULT_CALCULATORS.map { |c| "#{c}CalculatorService".constantize }
  end

  def my_fields_required
    MY_FIELDS - inputs.keys
  end

  def perform_calculation_using(calculator)
    result = calculator.call(inputs)
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
    self.available_help = :undecided
    messages.concat result.messages
  end

  def add_failure(result, identifier:)
    self.available_help = :none
    self.final_decision_by = identifier if result.final_decision?
    messages.concat result.messages
  end

  def add_success(result, identifier:)
    self.available_help = result.available_help
    self.final_decision_by = identifier if result.final_decision?
    # The remission is always from the last value given,
    # so its ok to overwrite this
    self.remission = result.remission
    messages.concat result.messages
  end

  attr_accessor :calculators
  attr_writer :messages, :inputs, :available_help, :remission, :final_decision_by
end
