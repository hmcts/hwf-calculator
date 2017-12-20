# A form object for the calculation data, probably coming from the HTTP session
# but not limited to this usage.
#
# Note that whilst the attributes are defined as being the correct value or :undefined,
# when exported, any :undefined values are not exported.
#
# Also, note that invalid attributes can contain any value of any type, so if the
# form is not valid? then do not rely on them being of the correct type.
class CalculationForm < BaseForm
  UNDEFINED = :undefined

  # @!attribute [rw] marital_status
  #   @return [String,Symbol] Either 'single', 'sharing_income' or :undefined
  attribute :marital_status, :string, default: UNDEFINED
  # @!attribute [rw] date_of_birth
  #   @return [Date,Symbol] Either a date specifying the date of birth, or :undefined
  attribute :date_of_birth, :date, default: UNDEFINED
  # @!attribute [rw] fee
  #   @return [Float,Symbol] Either a float value defining the court fee, or :undefined
  attribute :fee, :float, default: UNDEFINED
  # @!attribute [rw] disposable_capital
  #   @return [Float,Symbol] Either a float value defining the disposable capital, or :undefined
  attribute :disposable_capital, :float, default: UNDEFINED
  # @!attribute [rw] benefits_received
  #   @return [Array<String>] Either an array of strings, or :undefined
  attribute :benefits_received, :array, default: UNDEFINED

  private

  def export_params
    instance_values.reject { |_k, v| v == UNDEFINED }.symbolize_keys
  end
end
