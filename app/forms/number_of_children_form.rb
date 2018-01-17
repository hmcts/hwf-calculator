# A form object for the number of children
class NumberOfChildrenForm < BaseForm
  # @!attribute [rw] fee
  #   @return [Integer] The number of children
  attribute :number_of_children, :strict_integer

  validates :number_of_children, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The type of the form
  #
  # @return [Symbol] :number_of_children
  def type
    :number_of_children
  end

  private

  def export_params
    {
      number_of_children: number_of_children
    }
  end
end
