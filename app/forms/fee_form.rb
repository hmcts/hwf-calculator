class FeeForm < BaseForm
  attribute :fee, :float

  def type
    :fee
  end

  private

  def export_params
    {
        fee: fee
    }
  end
end
