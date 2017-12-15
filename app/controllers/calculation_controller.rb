class CalculationController < ApplicationController
  helper_method :form, :current_calculation

  # (PATCH | PUT) /calculation
  def update
    form = form_class.new(calculation_params.to_h)
    if form.valid?
      calculate(form.export)
    else
      render :new
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
  # @return [NilForm,MaritalStatusForm,FeeForm,DateOfBirthForm,TotalSavingsForm,BenefitsReceivedForm] The form to use
  def form
    @form ||= form_class.new
  end

  private

  def expire_current_calculation
    @current_calculation = nil
  end

  def calculate(input_data)
    data = current_calculation.inputs.merge(input_data)
    submit_service = CalculationService.call(data)
    expire_current_calculation
    session[:calculation] = submit_service.to_h
    redirect_to edit_calculation_url(form: submit_service.fields_required.first)
  end

  def form_class
    CalculationFormService.for(params[:form].try(:to_sym))
  end

  def calculation_params
    params.require(:calculation).permit(:marital_status, :fee, :date_of_birth, :total_savings)
  end
end
