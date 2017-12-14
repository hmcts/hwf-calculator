class CalculationForm
  include ActiveModel::Model
  include ActiveModelAttributes

  UNDEFINED = :undefined
  PERMITTED_ATTRIBUTES = {
    marital_status: String,
    date_of_birth: Date,
    fee: Float,
    total_savings: Float
  }

  attribute :marital_status, :string
  attribute :date_of_birth, :date
  attribute :fee, :float
  attribute :total_savings, :float

  def initialize(*args)
    PERMITTED_ATTRIBUTES.keys.each do |attr|
      instance_variable_set("@#{attr}", UNDEFINED)
    end
    super
  end

  def to_h
    instance_values.reject {|k,v| v == UNDEFINED}.symbolize_keys
  end
end
