module ApplicationHelper
  # Provides the feedback text for a given calculation.
  # At present, this does use I18n to generate the text, using approximately 10 different keys to form the
  # complete feedback message.
  # It is currently unknown if this will be suitable for different languages (i.e. welsh)
  # @TODO Review the above comment
  # @param [Calculator::Calculation] calculation The calculation to display feedback for
  # @return [String] The feedback text
  def calculator_feedback_for(calculation)
    if calculation.should_not_get_help
      _should_not_get_help_text(calculation)
    elsif calculation.should_get_help
      _should_get_help_text(calculation) + ' ' + calculator_feedback_explanation(calculation).join(' ')
    end
  end

  # Formats a calculator value.
  #
  # @TODO Decide if this stays as a type detection based method or has a type lookup from somewhere
  # @TODO Decide if the code that needs this really needs a presenter
  # @param [Object] value The value to be formatted
  # @param [String] field The field that this value is from
  def calculator_auto_format_for(value, field:)
    case value
    when Float then number_to_currency(value, precision: 0, unit: '£')
    when Date then value.strftime('%d/%m/%Y')
    else value
    end
  end

  def calculation_fee(calculation)
    number_to_currency(calculation.inputs['fee'], precision: 0, unit: '£')
  end

  def calculation_total_savings(calculation)
    number_to_currency(calculation.inputs['total_savings'], precision: 0, unit: '£')
  end

  private

  def _should_not_get_help_text(calculation)
    [
      I18n.t('calculation.feedback.should_not_get_help'),
      I18n.t('calculation.feedback.explanation_prefix',
        fee: number_to_currency(calculation.inputs['fee'], precision: 0, unit: '£'),
        total_savings: calculation_total_savings(calculation)),
      I18n.t('calculation.feedback.explanation.negative')
    ].join(' ')
  end

  def _should_get_help_text(calculation)
    [
      I18n.t('calculation.feedback.should_get_help'),
      I18n.t('calculation.feedback.explanation_prefix',
        fee: calculation_fee(calculation),
        total_savings: number_to_currency(calculation.inputs['total_savings'], precision: 0, unit: '£')),
      I18n.t("calculation.feedback.subject.#{calculation.inputs['marital_status']}"),
      I18n.t('calculation.feedback.explanation.positive')
    ].join(' ')
  end

  def calculator_feedback_explanation(calculation)
    remaining_fields = calculation.required_fields_affecting_likelyhood
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
