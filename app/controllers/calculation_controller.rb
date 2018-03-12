# The main controller for performing calculations in a question by question
# manner.
class CalculationController < ApplicationController
  include CalculationStore
  helper_method :form
  before_action :ensure_calculation_initialized, only: :update
  before_action :start_again, unless: :calculation_state_valid?, except: :home

  def home
    repo.delete_all
  end

  # (PATCH | PUT) /calculation
  def update
    self.form = form_class.new(calculation_params.to_h)
    if form.valid?
      calculate
      save_current_calculation
      redirect_to next_url
    else
      render :edit
    end
  end

  def edit
    self.form = form_class.new_ignoring_extras(current_calculation.inputs.to_hash)
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

  def calculate
    CalculationService.call(form.export, current_calculation).result
  end

  def next_url(calculation: current_calculation, form_service: CalculationFormService)
    fields_required = calculation.inputs.fields_required
    if calculation.final_decision_made? || fields_required.empty?
      send("calculation_result_#{calculation.available_help}_url".to_sym)
    else
      edit_calculation_url(form: form_service.for_field(fields_required.first).type)
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

  def start_again
    redirect_to root_path
    false
  end
end
