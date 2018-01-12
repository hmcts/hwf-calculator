# A form object for the benefits received question.
class BenefitsReceivedForm < BaseForm
  VALID_BENEFITS = [
    :jobseekers_allowance,
    :employment_support_allowance,
    :income_support,
    :universal_credit,
    :pension_credit,
    :scottish_legal_aid,
    :none,
    :dont_know
  ].freeze

  attribute :benefits_received, :array
  validates :benefits_received, presence: true
  validate :validate_benefits_received_type
  validate :validate_benefits_received_dont_know_with_extras
  validate :validate_benefits_received_none_with_extras
  validate :validate_benefits_received_values
  # The type of the form
  #
  # @return [Symbol] - :benefits_received
  def type
    :benefits_received
  end

  # @return [Array<Symbol>] An array of symbols representing the different types of benefits
  def benefits
    VALID_BENEFITS
  end

  def benefits_received=(v)
    super v.is_a?(Array) ? convert_benefits_array(v) : v
  end

  private

  def convert_benefits_array(v)
    benefits_converted = v.reject(&:empty?)
    stringify_benefits = benefits.to_s
    benefits_converted.map! do |benefit|
      stringify_benefits.include?(benefit) ? benefit.to_sym : benefit
    end
    benefits_converted
  end

  def validate_benefits_received_type
    return if benefits_received.is_a?(Array)
    errors.add :benefits_received, :invalid_type
  end

  def validate_benefits_received_dont_know_with_extras
    return unless benefits_received.is_a?(Array)
    if benefits_received.include?(:dont_know) && benefits_received.length > 1
      errors.add :benefits_received, :dont_know_with_extras
    end
  end

  def validate_benefits_received_none_with_extras
    return unless benefits_received.is_a?(Array)
    if benefits_received.include?(:none) && benefits_received.length > 1
      errors.add :benefits_received, :none_with_extras
    end
  end

  def validate_benefits_received_values
    return unless benefits_received.is_a?(Array)
    return if benefits_received.all? { |b| VALID_BENEFITS.include?(b) }
    errors.add :benefits_received, :invalid_value
  end

  def export_params
    {
      benefits_received: benefits_received
    }
  end
end
