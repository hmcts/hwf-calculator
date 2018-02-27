# A calculator service for the household income for an individual or couple
#
class HouseholdIncomeCalculatorService < BaseCalculatorService
  MY_FIELDS = [:marital_status, :fee, :number_of_children, :total_income].freeze
  MINIMUM_THRESHOLD = { single: 1085, sharing_income: 1245 }.freeze
  MAXIMUM_THRESHOLD = { single: 5085, sharing_income: 5245 }.freeze
  CHILD_ALLOWANCE = 245
  VALID_MARITAL_STATUS = ['single', 'sharing_income'].freeze

  def valid?
    all_inputs_present? && all_inputs_correct_type?
  end

  def call
    return self unless valid?
    if lte_minimum?
      mark_as_help_available
    elsif above_minimum? && lte_maximum?
      mark_as_partial_help_available
    else
      mark_as_help_not_available
    end
    self
  end

  private

  def all_inputs_present?
    ([:fee, :marital_status, :total_income, :number_of_children] - inputs.keys).empty?
  end

  def all_inputs_correct_type?
    VALID_MARITAL_STATUS.include?(inputs[:marital_status]) &&
      inputs[:total_income].is_a?(Float) &&
      inputs[:fee].is_a?(Float) &&
      inputs[:number_of_children].is_a?(Integer)
  end

  def lte_minimum?
    !above_minimum?
  end

  def above_minimum?
    inputs[:total_income] > minimum_threshold
  end

  def lte_maximum?
    !above_maximum?
  end

  def above_maximum?
    inputs[:total_income] > maximum_threshold
  end

  def minimum_threshold
    MINIMUM_THRESHOLD[inputs[:marital_status].to_sym] + children_allowance
  end

  def maximum_threshold
    MAXIMUM_THRESHOLD[inputs[:marital_status].to_sym] + children_allowance
  end

  def children_allowance
    (inputs[:number_of_children] * CHILD_ALLOWANCE)
  end

  def mark_as_help_available
    self.available_help = :full
    self.final_decision = true
    messages << { key: :final_positive, source: :household_income, classification: :positive }
  end

  def mark_as_partial_help_available
    self.available_help = :partial
    self.remission = calculate_remission
    self.final_decision = true
    messages << { key: :final_partial, source: :household_income, classification: :positive }
  end

  def mark_as_help_not_available
    self.available_help = :none
    self.final_decision = true
    messages << { key: :final_negative, source: :household_income, classification: :negative }
  end

  def calculate_remission
    over = (inputs[:total_income] - minimum_threshold).to_i
    citizen_pays = (over / 10) * 5
    remission = [0, inputs[:fee].to_i - citizen_pays].max
    (remission / 10) * 10.0
  end
end
