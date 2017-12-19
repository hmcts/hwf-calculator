# A form object for the disposable capital question
class DisposableCapitalForm < BaseForm
  # @!attribute [rw] disposable_capital
  #   @return [Float] The disposable capital
  attribute :disposable_capital, :float

  # The form type
  #
  # @return [Symbol] :disposable_capital
  def type
    :disposable_capital
  end

  private

  def export_params
    {
      disposable_capital: disposable_capital
    }
  end
end
