# A calculator service for the benefits received for an individual or couple
#
class BenefitsReceivedCalculatorService < BaseCalculatorService
  MY_FIELDS = [:benefits_received].freeze

  def initialize(attrs)
    attrs = attrs.dup # Dont modify inputs
    attrs[:benefits_received] = attrs[:benefits_received].map(&:to_sym) if attrs[:benefits_received].is_a?(Array)
    super(attrs)
  end

  def call
    throw :invalid_inputs, self unless valid?
    process_inputs
  end

  def valid?
    inputs[:benefits_received].is_a?(Array)
  end

  def self.fields_required(inputs, *)
    MY_FIELDS - inputs.keys
  end

  private

  def process_inputs
    benefits = inputs[:benefits_received]
    if benefits.include?(:none) || benefits.include?(:dont_know)
      mark_as_undecided
    elsif benefits.present?
      mark_as_help_available
    end
    self
  end

  def mark_as_help_available
    self.available_help = :full
    self.final_decision = true
    messages << { key: :final_positive, source: :benefits_received, classification: :positive }
  end

  def mark_as_undecided
    self.available_help = :undecided
  end
end
