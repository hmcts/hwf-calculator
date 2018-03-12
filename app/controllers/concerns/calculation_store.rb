module CalculationStore
  extend ActiveSupport::Concern

  included do
    helper_method :current_calculation
  end

  private

  def save_current_calculation
    repo.save(current_calculation)
  end

  def current_calculation
    @current_calculation ||= repo.find
  end

  def expire_current_calculation
    @current_calculation = nil
  end

  def start_current_calculation
    current_calculation.reset_messages
  end

  def repo
    @repo ||= CalculationRepository.new(store: session)
  end

  def calculation_state_valid?
    current_calculation.state_valid?
  end

  def ensure_calculation_initialized
    current_calculation.initialized = true
  end
end
