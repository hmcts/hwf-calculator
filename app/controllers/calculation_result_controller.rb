# This controller handles all final results from the calculator - either full, none or partial
class CalculationResultController < ApplicationController
  helper_method :current_calculation

  # The current calculation from the session converted into a @see Calculation instance
  #
  # @return [Calculation] The current calculation
  def current_calculation
    @current_calculation ||= Calculation.new(session.fetch(:calculation) { {} }.symbolize_keys)
  end
end
