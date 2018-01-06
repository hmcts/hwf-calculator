# A form object for the total income
class TotalIncomeForm < BaseForm
  # @!attribute [rw] fee
  #   @return [Float] The total income
  attribute :total_income, :float

  # The type of the form
  #
  # @return [Symbol] :total_income
  def type
    :total_income
  end

  private

  def export_params
    {
      total_income: total_income
    }
  end
end
