module CalculationFeedbackHelper
  # Provides the feedback text for a given calculation.
  # @param [Calculator::Calculation] calculation The calculation to display feedback for
  # @return [String] The feedback text
  def calculator_feedback_for(calculation)
    message = calculation.messages.last
    return '' if message.nil?
    marital_status = calculation.inputs[:marital_status]
    t "calculation.feedback.messages.decided_by.#{message['source']}.#{message['key']}.detail.#{marital_status}",
      raise: true,
      total_income: calculation_total_income(calculation),
      fee: calculation_fee(calculation),
      disposable_capital: calculation_disposable_capital(calculation),
      remission: calculation_remission(calculation),
      contribution: calculation_contribution(calculation)
  end

  # Provides the feedback header text for a given calculation.
  # @param [Calculator::Calculation] calculation The calculation to display feedback header for
  # @return [String] The feedback header text
  def calculator_feedback_header_for(calculation)
    message = calculation.messages.last
    return '' if message.nil?
    t "calculation.feedback.messages.decided_by.#{message['source']}.#{message['key']}.header",
      raise: true
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
    return '' if calculation.remission.nil?
    number_to_currency(calculation.remission, precision: 0, unit: '£')
  end

  # Presents the calculation citizen contribution in the correct format
  #
  # @param [Calculation] calculation The calculation to get the contribution from
  #
  # @return [String] The text to display
  def calculation_contribution(calculation)
    return '' if calculation.inputs[:fee].nil? || calculation.remission.nil?
    number_to_currency(calculation.inputs[:fee] - calculation.remission, precision: 0, unit: '£')
  end

  # Presents the calculation total income in the correct format
  #
  # @param [Calculation] calculation The calculation to get the total income from
  #
  # @return [String] The text to display
  def calculation_total_income(calculation)
    return '' if calculation.inputs[:total_income].nil?
    number_to_currency(calculation.inputs[:total_income], precision: 0, unit: '£')
  end

  # Presents the calculation disposable capital in the correct format
  #
  # @param [Calculation] calculation The calculation to get the disposable capital from
  #
  # @return [String] The text to display
  def calculation_disposable_capital(calculation)
    return '' if calculation.inputs[:disposable_capital].nil?
    number_to_currency(calculation.inputs[:disposable_capital], precision: 0, unit: '£')
  end

  # Finds the first form that handles the field given
  #
  # @param [String] field The field to find the form for
  # @return [NilForm,MaritalStatusForm,FeeForm,DateOfBirthForm,
  #   DisposableCapitalForm,BenefitsReceivedForm,NumberOfChildrenForm] The form
  def calculator_form_for(field)
    CalculationFormService.for_field(field)
  end
end
