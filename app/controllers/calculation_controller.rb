# The main controller for performing calculations in a question by question
# manner.  Note that at the time of writing this comment, the validation feedback
# has not been added, hence the form_class being instantiated with no data
# @TODO Review this comment once validation has been added
class CalculationController < ApplicationController
  helper_method :form, :current_calculation

  # (PATCH | PUT) /calculation
  def update
    form = form_class.new(calculation_params.to_h)
    if form.valid?
      calculate(form.export)
    else
      render :edit
    end
  end

  # The current calculation from the session converted into a @see Calculation instance
  #
  # @return [Calculation] The current calculation
  def current_calculation
    @current_calculation ||= Calculation.new(session.fetch(:calculation) { {} }.symbolize_keys)
  end

  # The form to use to capture the input data
  #
  # @return [NilForm,MaritalStatusForm,FeeForm,DateOfBirthForm,
  #   DisposableCapitalForm,BenefitsReceivedForm] The form to use
  def form
    @form ||= form_class.new
  end

  private

  def expire_current_calculation
    @current_calculation = nil
  end

  def calculate(input_data)
    submit_service = CalculationService.call(current_calculation.inputs.merge(input_data))
    expire_current_calculation
    session[:calculation] = submit_service.to_h
    redirect_to_next_question(submit_service)
  end

  def redirect_to_next_question(submit_service)
    redirect_to edit_calculation_url(form: submit_service.fields_required.first)
  end

  def form_class
    CalculationFormService.for(params[:form].try(:to_sym))
  end

  def calculation_params
    params.require(:calculation).permit(:marital_status, :fee, :date_of_birth, :disposable_capital)
  end
end
