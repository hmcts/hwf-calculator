# The main controller for performing calculations in a question by question
# manner.
class CalculationController < ApplicationController
  include CalculationStore
  helper_method :form

  def home
    repo.delete_all
  end

  # (PATCH | PUT) /calculation
  def update
    self.form = form_class.new(calculation_params.to_h)
    if form.valid?
      calculation = calculate
      redirect_to next_url(calculation)
    else
      render :edit
    end
  end

  def edit
    self.form = form_class.new_ignoring_extras(current_calculation.inputs)
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
    calculation = CalculationService.call(form.export, current_calculation).result
    repo.save(calculation)
    calculation
  end

  def next_url(calculation, form_service: CalculationFormService)
    if calculation.final_decision_made? || calculation.fields_required.empty?
      send("calculation_result_#{calculation.available_help}_url".to_sym)
    else
      edit_calculation_url(form: form_service.for_field(calculation.fields_required.first).type)
    end
  end

  def form_class
    CalculationFormService.for(params[:form].try(:to_sym))
  end

  def calculation_params
    params.require(:calculation).permit :marital_status,
      :fee,
      :disposable_capital,
      :number_of_children,
      :total_income,
      date_of_birth: [:day, :month, :year],
      partner_date_of_birth: [:day, :month, :year],
      benefits_received: []
  end
end
