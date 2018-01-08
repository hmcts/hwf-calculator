# A form object for the court fee
# Note that this form captures the fee as an integer, but exports it as a float
# this allows the underlying calculation engine to use floats for precision (i.e. rounding at the end of,
# not during calculations)
class FeeForm < BaseForm
  # @!attribute [rw] fee
  #   @return [Integer] The court fee
  attribute :fee, :strict_integer

  validates :fee, numericality: { only_integer: true }

  # The type of the form
  #
  # @return [Symbol] :fee
  def type
    :fee
  end

  private

  def export_params
    {
      fee: fee.to_f
    }
  end
end
