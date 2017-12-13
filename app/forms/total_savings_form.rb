class TotalSavingsForm < BaseForm
  attribute :total_savings, :float

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
