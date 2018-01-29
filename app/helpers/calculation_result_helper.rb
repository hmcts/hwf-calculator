module CalculationResultHelper
  # @param [Calculation] calculation If a result is given early and the inputs have data
  # in them which will not be used, this method will list those inputs
  # @return [Array<Symbol>] A list of inputs that will be ignored
  def ignored_fields_for(calculation)
    case calculation.final_decision_by.to_sym
    when :disposable_capital then [:benefits_received, :number_of_children, :total_income]
    when :benefits_received then [:number_of_children, :total_income]
    else []
    end
  end
end