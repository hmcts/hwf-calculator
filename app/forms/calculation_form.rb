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
  UNDEFINED_STRING = OpenStruct.new(to_s: "")
  UNDEFINED_FLOAT = OpenStruct.new(to_f: 0)
  UNDEFINED_DATE = OpenStruct.new()
  UNDEFINED_INTEGER = OpenStruct.new

  # @!attribute [rw] marital_status
  #   @return [String,Symbol] Either 'single', 'sharing_income' or :undefined
  attribute :marital_status, :string
  # @!attribute [rw] date_of_birth
  #   @return [Date,Symbol] Either a date specifying the date of birth, or :undefined
  attribute :date_of_birth, :date
  # @!attribute [rw] partner_date_of_birth
  #   @return [Date,Symbol,nil] Either a date specifying the partner's date of birth, nil (if no partner), or :undefined
  attribute :partner_date_of_birth, :date
  # @!attribute [rw] fee
  #   @return [Float,Symbol] Either a float value defining the court fee, or :undefined
  attribute :fee, :float
  # @!attribute [rw] disposable_capital
  #   @return [Float,Symbol] Either a float value defining the disposable capital, or :undefined
  attribute :disposable_capital, :float
  # @!attribute [rw] benefits_received
  #   @return [Array<String>] Either an array of strings, or :undefined
  attribute :benefits_received, :array
  # @!attribute [rw] number_of_children
  #   @return [Fixnum,Symbol] Either an integer value defining the number of children, or :undefined
  attribute :number_of_children, :integer
  # @!attribute [rw] total_income
  #   @return [Float,Symbol] Either a float value defining the total income, or :undefined
  attribute :total_income, :float

  def initialize(attrs)
    self.my_initialized_attrs = attrs.keys.map(&:to_s)
    super
  end

  private

  def export_params
    to_write = (my_initialized_attrs + changed).uniq
    attributes.inject({}) do |acc, (k, v)|
      acc[k.to_sym] = v if to_write.include?(k)
      acc
    end
  end

  attr_accessor :my_initialized_attrs

end
