class CalculationController < ApplicationController
  FORM_CLASSES = {
    nil => NilForm,
    marital_status: MaritalStatusForm,
    fee: FeeForm,
    date_of_birth: DateOfBirthForm,
    total_savings: TotalSavingsForm,
    benefits_received: BenefitsReceivedForm

  }.freeze

  def home
    render locals: { form: form_class.new, current_calculation: current_calculation }
  end

  def edit
    render locals: { form: form_class.new, current_calculation: current_calculation }
  end

  def update
    @form = form_class.new(calculation_params.to_h)
    if @form.valid?
      calculate(@form.export)
    else
      render :new
    end
  end

  private

  def current_calculation
    @current_calculation = Calculation.new(session.fetch(:calculation) { {} }.symbolize_keys)
  end

  def expire_current_calculation
    @current_calculation = nil
  end

  def calculate(input_data)
    data = current_calculation.inputs.merge(input_data)
    submit_service = CalculationService.new(data)
    submit_service.call
    expire_current_calculation
    session[:calculation] = submit_service.to_h
    redirect_to edit_calculation_url(form: submit_service.fields_required.first)
  end

  def form_class
    klass = FORM_CLASSES[params[:form].try(:to_sym)]
    raise "Unknown form class for '#{params[:form]}'" if klass.nil?
    klass
  end

  def calculation_params
    params.require(:calculation).permit(:marital_status, :fee, :date_of_birth, :total_savings)
  end

  def submit_service(config = Rails.configuration)
    @submit_service ||= SubmitCalculationService.new(config.api['base_url'], config.api['token'])
  end
end
