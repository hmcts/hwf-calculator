# The primary interface for the calculator
#
#
class CalculationService
  # @TODO This is now defined in the form object - can anything be shared here ?
  FIELDS = %i[marital_status fee date_of_birth total_savings benefits_received number_of_children total_income].freeze
  FIELDS_AFFECTING_LIKELYHOOD = %i[date_of_birth total_savings benefits_received total_income].freeze
  attr_reader :messages, :inputs

  def initialize(inputs, calculators: [TotalSavingsSubCalculationService])
    self.inputs = inputs.freeze
    self.failed = false
    self.help_available = false
    self.messages = []
    self.calculators = calculators
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    # @TODO Decide what to do here and remove this comment
    # There are 2 catch blocks here which at present has little value
    # but, I am planning ahead a little in that invalid inputs might
    # want to add something to this instance in terms of messages etc..
    # but unsure right now.
    catch(:abort) do
      calculators.each do |calculator|
        my_result = catch(:invalid_inputs) do
          perform_calculation_using(calculator)
        end
        throw :abort, self unless my_result.valid?
      end
    end
    self
  end

  def to_h
    {
      inputs: inputs,
      should_get_help: help_available?,
      should_not_get_help: help_not_available?,
      fields_required: fields_required,
      required_fields_affecting_likelyhood: required_fields_affecting_likelyhood,
      messages: messages
    }
  end

  def help_not_available?
    failed
  end

  def help_available?
    help_available
  end

  def fields_required
    FIELDS - inputs.keys
  end

  def required_fields_affecting_likelyhood
    FIELDS_AFFECTING_LIKELYHOOD - inputs.keys
  end

  private

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
  attr_writer :messages, :inputs
end
