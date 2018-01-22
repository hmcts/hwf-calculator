# The main controller for performing calculations in a question by question
# manner.
class CalculationController < ApplicationController
  helper_method :form, :current_calculation

  def home
    session.delete(:calculation)
  end

  # (PATCH | PUT) /calculation
  def update
    self.form = form_class.new(calculation_params.to_h)
    if form.valid?
      submit_service = calculate
      redirect_to next_url(submit_service)
    else
      render :edit
    end
  end

  def edit
    self.form = form_class.new_ignoring_extras(current_calculation.inputs)
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

  attr_writer :form

  def expire_current_calculation
    @current_calculation = nil
  end

  def calculate
    submit_service = CalculationService.call(current_calculation.inputs.merge(form.export))
    expire_current_calculation
    session[:calculation] = submit_service.to_h
    submit_service
  end

  def next_url(submit_service)
    if submit_service.final_decision_made? || submit_service.fields_required.empty?
      send("calculation_result_#{submit_service.available_help}_url".to_sym)
    else
      edit_calculation_url(form: submit_service.fields_required.first)
    end
  end

  def form_class
    CalculationFormService.for(params[:form].try(:to_sym))
  end

  def calculation_params
    params.require(:calculation).permit :marital_status,
      :fee,
      :date_of_birth,
      :partner_date_of_birth,
      :disposable_capital,
      :number_of_children,
      :total_income,
      benefits_received: []
  end
end
