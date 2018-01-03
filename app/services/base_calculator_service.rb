# An abstract base class for all calculator services, used to define a common
# interface.
#
# All calculators can be called using 'call' on the class itself, which will return an instance
# with the results.
# The caller can then call @see help_available? and @see help_not_available? to determine if
# a decision has been made by this calculator.  If both are false, then it cannot make a decision
# and the caller will generally move on to the next calculator in the chain.
#
# The reasons for the decisions are given in the @see messages array, which contain a list
# of hashes looking like this
#
# @example A messages hash
#
#   { key: :i18n_key, source: :underscored_name_of_calculator }
#
# The caller can then use I18n translation to convert these into text to present to the user.
#
# So, if we had a sub class like this
#
# @example Defining a calculator service
#   class MyCalculatorService < BaseCalculatorService
#     def call
#       do_something
#       self.help_available = true
#       messages << { key: :likely, source: :my_calculator }
#       self
#     end
#   end
#
# Then we could could call it like this
#
# @exammple Calling the above calculator service
#   inputs = {
#     my_input_1: 12,
#     my_input_2: 24
#   }
#   result = MyCalculatorService.call(inputs)
#   result.help_available?  # => true
#   result.messages # => [{ key: :likely, source: :my_calculator}]
#
# @abstract
class BaseCalculatorService
  attr_reader :messages

  # Perform the calculation
  # @param [Hash] inputs The inputs (with symbolized keys) for the calculator
  # @return [BaseCalculatorService] An instance which will be a base calculator service or a sub class
  def self.call(inputs)
    new(inputs).call
  end

  # An identifier for use by the calculation service to store results against
  # @return [Symbol] The identifier - usually derived from the class name
  def self.identifier
    name.demodulize.underscore.to_sym
  end

  def self.fields_required(_inputs, *)
    raise 'Not Implemented'
  end

  # @private
  # Not expected to be used directly - use the class .call method instead
  def initialize(inputs)
    self.inputs = inputs
    self.messages = []
    self.help_not_available = false
    self.help_available = false
  end

  # @private
  # Not expected to be used directly - use the class.call method instead. Performs the calculation
  def call
    raise 'Not Implemented'
  end

  # Indicates if help is not available
  # @return [Boolean] Help is not available (if true) or 'depends on help_available?' (if false)
  def help_not_available?
    help_not_available
  end

  # Indicates if help is available
  # @return [Boolean] Help is available (if true) or 'depends on help_not_available?' (if false)
  def help_available?
    help_available
  end

  # Indicates if the inputs were all valid
  #
  # @return [Boolean] If true, all inputs were valid, else false
  def valid?
    raise 'Not Implemented'
  end

  private

  attr_accessor :inputs
  attr_writer :messages
  attr_accessor :help_available, :help_not_available
end
