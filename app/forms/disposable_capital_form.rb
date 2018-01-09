# A form object for the disposable capital question
class DisposableCapitalForm < BaseForm
  # @!attribute [rw] disposable_capital
  #   @return [Integer] The disposable capital
  attribute :disposable_capital, :strict_integer

  validates :disposable_capital, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 0, allow_blank: true
  }

  # The form type
  #
  # @return [Symbol] :disposable_capital
  def type
    :disposable_capital
  end

  private

  def export_params
    {
      disposable_capital: disposable_capital.to_f
    }
  end
end
