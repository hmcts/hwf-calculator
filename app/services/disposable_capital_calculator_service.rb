# A calculator service for the disposable capital of an individual or couple
#
# Uses an internal lookup table to decide based on the age (of the eldest), the court fee,
# and the disposable_capital of the person or couple.
class DisposableCapitalCalculatorService < BaseCalculatorService
  FEE_TABLE = [
    { age: 1..60, fee: 1..1000, disposable_capital: 3000 }.freeze,
    { age: 1..60, fee: 1001..1335, disposable_capital: 4000 }.freeze,
    { age: 1..60, fee: 1336..1665, disposable_capital: 5000 }.freeze,
    { age: 1..60, fee: 1666..2000, disposable_capital: 6000 }.freeze,
    { age: 1..60, fee: 2001..2330, disposable_capital: 7000 }.freeze,
    { age: 1..60, fee: 2331..4000, disposable_capital: 8000 }.freeze,
    { age: 1..60, fee: 4001..5000, disposable_capital: 10000 }.freeze,
    { age: 1..60, fee: 5001..6000, disposable_capital: 12000 }.freeze,
    { age: 1..60, fee: 6001..7000, disposable_capital: 14000 }.freeze,
    { age: 1..60, fee: 7001..Float::INFINITY, disposable_capital: 16000 }.freeze,
    { age: 61..200, fee: 1..Float::INFINITY, disposable_capital: 16000 }.freeze
  ].freeze
  MY_FIELDS = [:fee, :date_of_birth, :disposable_capital].freeze

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
      inputs[:disposable_capital].is_a?(Numeric)
  end

  def self.fields_required(inputs, *)
    MY_FIELDS - inputs.keys
  end

  private

  def process_inputs
    fee_band = find_fee_band_for(age: age_service.call(date_of_birth: inputs[:date_of_birth]), fee: inputs[:fee])
    if inputs[:disposable_capital] < fee_band[:disposable_capital]
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
    self.available_help = :full
    messages << { key: :likely, source: :disposable_capital }
  end

  def mark_as_help_not_available
    self.available_help = :none
    messages << { key: :unlikely, source: :disposable_capital }
  end

  attr_accessor :age_service
end
