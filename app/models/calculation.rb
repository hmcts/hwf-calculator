class   Calculation
  include ActiveModel::Model
  attr_accessor :inputs, :should_get_help, :should_not_get_help, :fields_required
  attr_accessor :required_fields_affecting_likelyhood, :messages, :fields

  def initialize(attrs = {})
    local_attrs = attrs.dup
    self.should_get_help = false
    self.should_not_get_help = false
    self.fields_required = []
    self.required_fields_affecting_likelyhood = []
    self.messages = []
    self.fields = {}
    local_attrs[:inputs] = CalculationForm.new(local_attrs.fetch(:inputs, {})).to_h
    super local_attrs
  end
end
