# A form object for the court fee
class FeeForm < BaseForm
  # @!attribute [rw] fee
  #   @return [Float] The court fee
  attribute :fee, :float

  # The type of the form
  #
  # @return [Symbol] :fee
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
