# A form object for the marital status question
class MaritalStatusForm < BaseForm
  # @!attribute [rw] marital_status
  #   @return [String] Either 'single' or 'sharing_income' (meaning married or equivalent)
  attribute :marital_status, :string

  validates :marital_status, inclusion: { in: %w[single sharing_income] }, allow_blank: false

  # The type of the form
  #
  # @return [Symbol] :marital_status
  def type
    :marital_status
  end

  private

  def export_params
    {
      marital_status: marital_status
    }
  end
end
