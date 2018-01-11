# The main controller for performing calculations in a question by question
# manner.  Note that at the time of writing this comment, the validation feedback
# has not been added, hence the form_class being instantiated with no data
# @TODO Review this comment once validation has been added
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
      redirect_to next_question_url(submit_service)
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

  def next_question_url(submit_service)
    if submit_service.fields_required.empty?
      remission_url(submit_service)
    else
      edit_calculation_url(form: submit_service.fields_required.first)
    end
  end

  def remission_url(submit_service)
    # @TODO Before merging in to master, decide what to do with the 'else' block
    form = case submit_service.available_help
           when :none then :no_remission_available
           when :partial then :partial_remission_available
           when :full then :full_remission_available
           else raise 'Could not make a decision - this should not happen, but no acceptance criteria exists for it yet'
           end
    edit_calculation_url(form: form)
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
