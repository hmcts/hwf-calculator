# A form object for the total income
class TotalIncomeForm < BaseForm
  # @!attribute [rw] fee
  #   @return [Integer] The total income
  attribute :total_income, :strict_integer

  validates :total_income, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 0, allow_blank: true
  }

  # The type of the form
  #
  # @return [Symbol] :total_income
  def type
    :total_income
  end

  private

  def export_params
    {
      total_income: total_income.to_f
    }
  end
end
