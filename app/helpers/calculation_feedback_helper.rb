module CalculationFeedbackHelper
  # Provides the feedback text for a given calculation.
  # At present, this does use I18n to generate the text, using approximately 10 different keys to form the
  # complete feedback message.
  # It is currently unknown if this will be suitable for different languages (i.e. welsh)
  # @TODO Review the above comment
  # @param [Calculator::Calculation] calculation The calculation to display feedback for
  # @return [String] The feedback text
  def calculator_feedback_for(calculation)
    if calculation.available_help == :none
      should_not_get_help_text(calculation)
    elsif calculation.available_help == :full
      should_get_help_text(calculation) + ' ' + calculator_feedback_explanation(calculation).join(' ')
    end
  end

  # Provides the final feedback text for a given calculation.
  # @param [Calculator::Calculation] calculation The calculation to display feedback for
  # @return [String] The feedback text
  def final_calculator_feedback_for(calculation)
    marital_status = calculation.inputs[:marital_status]
    t "calculation.feedback.full_remission.decided_by.#{calculation.final_decision_by}.#{marital_status}.detail",
      total_income: calculation_total_income(calculation),
      fee: calculation_fee(calculation)
  end

  # Provides the final partial feedback text for a given calculation.
  # @param [Calculator::Calculation] calculation The calculation to display feedback for
  # @return [String] The feedback text
  def partial_calculator_feedback_for(calculation)
    marital_status = calculation.inputs[:marital_status]
    t "calculation.feedback.partial_remission.#{marital_status}.detail",
      total_income: calculation_total_income(calculation),
      fee: calculation_fee(calculation),
      remission: calculation_remission(calculation),
      contribution: calculation_contribution(calculation)
  end

  # Presents the should not get help text in the current language
  # @param [Calculation] calculation The calculation
  #
  # @return [String] The text to present
  def should_not_get_help_text(calculation)
    I18n.t('calculation.feedback.message.negative',
      fee: calculation_fee(calculation),
      disposable_capital: calculation_disposable_capital(calculation))
  end

  # Presents the should get help text in the current language
  # @param [Calculation] calculation The calculation
  #
  # @return [String] The text to present
  def should_get_help_text(calculation)
    I18n.t('calculation.feedback.message.positive',
      fee: calculation_fee(calculation),
      disposable_capital: calculation_disposable_capital(calculation),
      subject: I18n.t("calculation.feedback.subject.#{calculation.inputs[:marital_status]}"))
  end

  # Formats a calculator value.
  #
  # @param [Object] value The value to be formatted
  # @param [String] field The field that this value is from
  def calculator_auto_format_for(value, field:)
    case field
    when :date_of_birth then
      value.strftime('%d/%m/%Y')
    when :fee, :disposable_capital then
      number_to_currency(value, precision: 0, unit: '£')
    when :benefits_received then
      value.map { |v| t("calculation.previous_questions.benefits_received.#{v}") }.join(',')
    else
      value
    end
  end

  # Presents the calculation fee in the correct format
  #
  # @param [Calculation] calculation The calculation to get the fee from
  #
  # @return [String] The text to display
  def calculation_fee(calculation)
    number_to_currency(calculation.inputs[:fee], precision: 0, unit: '£')
  end

  # Presents the calculation remission in the correct format
  #
  # @param [Calculation] calculation The calculation to get the remission from
  #
  # @return [String] The text to display
  def calculation_remission(calculation)
    number_to_currency(calculation.remission, precision: 0, unit: '£')
  end

  # Presents the calculation citizen contribution in the correct format
  #
  # @param [Calculation] calculation The calculation to get the contribution from
  #
  # @return [String] The text to display
  def calculation_contribution(calculation)
    number_to_currency(calculation.inputs[:fee] - calculation.remission, precision: 0, unit: '£')
  end

  # Presents the calculation total income in the correct format
  #
  # @param [Calculation] calculation The calculation to get the total income from
  #
  # @return [String] The text to display
  def calculation_total_income(calculation)
    number_to_currency(calculation.inputs[:total_income], precision: 0, unit: '£')
  end

  # Presents the calculation disposable capital in the correct format
  #
  # @param [Calculation] calculation The calculation to get the disposable capital from
  #
  # @return [String] The text to display
  def calculation_disposable_capital(calculation)
    number_to_currency(calculation.inputs[:disposable_capital], precision: 0, unit: '£')
  end

  private

  def calculator_feedback_explanation(calculation)
    remaining_fields = calculation.required_fields_affecting_likelihood
    return [] if remaining_fields.empty?
    a = [I18n.t('calculation.feedback.explanation_suffix')]
    remaining = remaining_fields.map do |field|
      I18n.t("calculation.feedback.explanation_suffix_fields.#{field}")
    end
    add_explanation_suffix(a, remaining)
  end

  def add_explanation_suffix(phrases, remaining)
    if remaining.length == 1
      phrases << remaining.first
    else
      phrases << remaining[0..-2].join(', ')
      phrases << I18n.t('calculation.feedback.explanation_suffix_joining_word')
      phrases << remaining.last
    end
    phrases
  end
end
