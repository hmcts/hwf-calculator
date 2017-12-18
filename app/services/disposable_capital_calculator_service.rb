# A calculator service for the total savings of an individual or couple
#
# Uses an internal lookup table to decide based on the age (of the eldest), the court fee,
# and the total_savings of the person or couple.
class DisposableCapitalCalculatorService < BaseCalculatorService
  FEE_TABLE = [
    { age: 1..60, fee: 1..1000, total_savings: 3000 }.freeze,
    { age: 1..60, fee: 1001..1335, total_savings: 4000 }.freeze,
    { age: 1..60, fee: 1336..1665, total_savings: 5000 }.freeze,
    { age: 1..60, fee: 1666..2000, total_savings: 6000 }.freeze,
    { age: 1..60, fee: 2001..2330, total_savings: 7000 }.freeze,
    { age: 1..60, fee: 2331..4000, total_savings: 8000 }.freeze,
    { age: 1..60, fee: 4001..5000, total_savings: 10000 }.freeze,
    { age: 1..60, fee: 5001..6000, total_savings: 12000 }.freeze,
    { age: 1..60, fee: 6001..7000, total_savings: 14000 }.freeze,
    { age: 1..60, fee: 7001..Float::INFINITY, total_savings: 16000 }.freeze,
    { age: 61..200, fee: 1..Float::INFINITY, total_savings: 16000 }.freeze
  ].freeze

  def initialize(age_service: AgeService, **args)
    self.age_service = age_service
    super args
  end

  def call
    throw :invalid_inputs, self unless valid?
    process_inputs
  end

  def valid?
    inputs[:date_of_birth].is_a?(Date) &&
      inputs[:fee].is_a?(Numeric) &&
      inputs[:total_savings].is_a?(Numeric)
  end

  private

  def process_inputs
    fee_band = find_fee_band_for(age: age_service.call(date_of_birth: inputs[:date_of_birth]), fee: inputs[:fee])
    if inputs[:total_savings] < fee_band[:total_savings]
      mark_as_help_available
    else
      mark_as_help_not_available
    end
    self
  end

  def find_fee_band_for(age:, fee:)
    fee_band = FEE_TABLE.find do |f|
      f[:age].cover?(age) && f[:fee].cover?(fee)
    end
    raise "Fee band not found for date_of_birth: #{inputs[:date_of_birth]} and fee: #{inputs[:fee]}" if fee_band.nil?
    fee_band
  end

  def mark_as_help_available
    self.help_available = true
    self.help_not_available = false
    messages << { key: :likely, source: :total_savings }
  end

  def mark_as_help_not_available
    self.help_not_available = true
    self.help_available = false
    messages << { key: :unlikely, source: :total_savings }
  end

  attr_accessor :age_service
end
