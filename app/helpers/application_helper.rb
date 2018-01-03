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
      should_not_get_help_text(calculation)
    elsif calculation.should_get_help
      should_get_help_text(calculation) + ' ' + calculator_feedback_explanation(calculation).join(' ')
    end
  end

  # Formats a calculator value.
  #
  # @param [Object] value The value to be formatted
  # @param [String] field The field that this value is from
  def calculator_auto_format_for(value, field:)
    case field
    when :date_of_birth then value.strftime('%d/%m/%Y')
    when :fee, :disposable_capital then number_to_currency(value, precision: 0, unit: '£')
    when :benefits_received then value.map { |v| t("calculation.previous_questions.benefits_received.#{v}") }.join(',')
    else value
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

  # Presents the calculation disposable capital in the correct format
  #
  # @param [Calculation] calculation The calculation to get the disposable capital from
  #
  # @return [String] The text to display
  def calculation_disposable_capital(calculation)
    number_to_currency(calculation.inputs[:disposable_capital], precision: 0, unit: '£')
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

  # Renders a group of checkboxes following GDS guidelines with guidance text
  #
  # @param [ActionView::Helpers::FormBuilder] form
  # @param [Symbol] method The active model attribute to generate the multiple choices for
  # @param [Array<Array>] choices An array of arrays where the inner array contains the 'key', the
  #   'display text' and 'guidance id' (nil for none)
  #   guidance id will mean more to you if you are familiar with GDS multiple choices with guidance
  #
  # @return [String] The HTML to render
  def gds_multiple_choices_with_guidance(form:, method:, choices:)
    form.collection_check_boxes method, choices, :first, :second do |b|
      guidance = b.object.last
      guidance_id = "prefix_#{b.object.first}"
      data_attrs = { target: guidance.present? ? guidance_id : nil }
      result = content_tag('div', class: 'multiple-choice', data: data_attrs) { b.check_box + b.label }
      if guidance.present?
        result << content_tag('div', guidance, class: 'panel panel-border-narrow js-hidden', id: guidance_id)
      end
      result
    end
  end

  # Renders error messages for an attribute from a model or form object
  # based on active model, but renders them
  # GDS style (span with a class of 'error-message')
  # @param [ActiveModel::Model] model The model or form object to get the errors from
  # @param [Symbol] method The attribute that you want the error messages for
  def gds_error_messages(model:, method:)
    errors = model.errors
    return '' unless errors.include?(method)
    errors.full_messages_for(method).each do |error|
      concat content_tag('span', error, class: 'error-message')
    end
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
