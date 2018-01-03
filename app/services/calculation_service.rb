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
#   service.required_fields_affecting_likelihood  # => []
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
#   service.required_fields_affecting_likelihood  # => [:date_of_birth, :disposable_capital,
#                                                       :benefits_received, :total_income]
#
# The second example shows that there is not a definitive answer yet,
# and further fields are required as specified in the correct order in 'fields_required'
# also 'required_fields_affecting_likelihood' lists any fields remaining that will affect the Yes/No
# result. This allows the front end to inform the user upon a partial success that it depends
# on them providing the listed fields.
#
class CalculationService
  MY_FIELDS = [:marital_status].freeze
  FIELDS_AFFECTING_LIKELIHOOD = [:date_of_birth, :disposable_capital, :benefits_received, :total_income].freeze
  DEFAULT_CALCULATORS = [
    'DisposableCapital',
    'BenefitsReceived',
    'HouseholdIncome'
  ].freeze
  attr_reader :messages, :inputs, :calculations

  # Create an instance of CalculationService
  # @param [Hash] inputs
  # @param [Array<BaseCalculatorService>] calculators A list of calculators to use.
  #  This is optional, normally for testing.
  # @return [CalculationService] This instance
  def initialize(inputs, calculators: default_calculators)
    self.inputs = inputs.freeze
    self.failed = false
    self.help_available = false
    self.messages = []
    self.calculators = calculators
    self.calculations = {}
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
    # @TODO Decide what to do here and remove this comment
    # There are 2 catch blocks here which at present has little value
    # but, I am planning ahead a little in that invalid inputs might
    # want to add something to this instance in terms of messages etc..
    # but unsure right now.
    catch(:abort) do
      calculators.each do |calculator|
        my_result = catch(:invalid_inputs) do
          calculations[calculator.identifier] = perform_calculation_using(calculator)
        end
        throw :abort, self unless my_result.valid?
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
      should_get_help: help_available?,
      should_not_get_help: help_not_available?,
      fields_required: fields_required,
      required_fields_affecting_likelihood: required_fields_affecting_likelihood,
      messages: messages
    }
  end

  # Indicates (if true) that help with fees is not available
  #
  # @return [Boolean] If true, help is not available.  If false, can mean undecided (if help_available? is also false)
  def help_not_available?
    failed
  end

  # Indicates (if true) that help with fees is available, but could be subject to more
  # fields being filled in (@see #fields_required and #required_fields_affecting_likelihood)
  #
  # @return [Boolean] If true, help is available given the provided inputs.  The
  # front end must take note of #fields_required to see if more info is required
  # to firm up this decision.  If false, can mean undecided (if help_not_available? is also false)
  def help_available?
    help_available
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
        c.fields_required(inputs, previous_calculations: calculations_summary)
      end.flatten
      my_fields_required + required
    end
  end

  # Indicates the fields that are required to be filled in that can change the Yes/No result.
  # This will exclude (for example) the number_of_children fields which might just change the
  # amount of help rather than the decision to provide help or not.
  #
  # @return [Array<Symbol>] An array of fields represented by symbols that need to be filled in
  # @see #fields_required for the list of symbols.
  def required_fields_affecting_likelihood
    FIELDS_AFFECTING_LIKELIHOOD - inputs.keys
  end

  private

  def default_calculators
    DEFAULT_CALCULATORS.map { |c| "#{c}CalculatorService".constantize }
  end

  def my_fields_required
    MY_FIELDS - inputs.keys
  end

  def calculations_summary
    calculations.map do |k, v|
      [k, { help_available: v.help_available?, help_not_available: v.help_not_available? }]
    end.to_h
  end

  def perform_calculation_using(calculator)
    result = calculator.call(inputs)
    if result.help_not_available?
      add_failure(result.messages)
      throw(:abort)
    end
    if result.help_available?
      add_success(result.messages)
    end
    result
  end

  def add_failure(reasons)
    self.failed = true
    messages.concat reasons
  end

  def add_success(success_messages)
    self.help_available = true
    messages.concat success_messages
  end

  attr_accessor :failed, :calculators, :help_available
  attr_writer :messages, :inputs, :calculations
end
