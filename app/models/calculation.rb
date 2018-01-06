class Calculation
  include ActiveModel::Model
  attr_accessor :inputs, :available_help, :remission, :fields_required
  attr_accessor :required_fields_affecting_likelihood, :messages, :fields

  def initialize(attrs = {})
    local_attrs = attrs.dup
    local_attrs[:available_help] = attrs.fetch(:available_help, :undecided).to_sym
    self.fields_required = []
    self.required_fields_affecting_likelihood = []
    self.messages = []
    self.fields = {}
    local_attrs[:inputs] = CalculationForm.new(local_attrs.fetch(:inputs, {})).export
    super local_attrs
  end
end
