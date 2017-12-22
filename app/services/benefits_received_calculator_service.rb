# A calculator service for the benefits received for an individual or couple
#
class BenefitsReceivedCalculatorService < BaseCalculatorService
  def call
    throw :invalid_inputs, self unless valid?
    process_inputs
  end

  def valid?
    inputs[:benefits_received].is_a?(Array)
  end

  private

  def process_inputs
    benefits = inputs[:benefits_received]
    unless benefits.empty? || benefits.include?(:none) || benefits.include?(:dont_know)
      mark_as_help_available
    end
    self
  end

  def mark_as_help_available
    self.help_available = true
    self.help_not_available = false
    messages << { key: :likely, source: :disposable_capital }
  end

  def mark_as_help_not_available
    self.help_not_available = true
    self.help_available = false
    messages << { key: :unlikely, source: :disposable_capital }
  end
end
