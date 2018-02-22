module CalculationStore
  extend ActiveSupport::Concern

  included do
    helper_method :current_calculation
  end

  # The current calculation from the session converted into a @see Calculation instance
  #
  # @return [Calculation] The current calculation
  def current_calculation
    @current_calculation ||= repo.find
  end

  private

  def repo
    @repo ||= CalculationRepository.new(store: session)
  end
end