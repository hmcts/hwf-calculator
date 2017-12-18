# A form object for the total savings question
class TotalSavingsForm < BaseForm
  # @!attribute [rw] total_savings
  #   @return [Float] The total savings
  attribute :total_savings, :float

  # The form type
  #
  # @return [Symbol] :total_savings
  def type
    :total_savings
  end

  private

  def export_params
    {
      total_savings: total_savings
    }
  end
end
