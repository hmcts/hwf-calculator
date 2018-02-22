class Calculation
  include ActiveModel::Model
  attr_accessor :available_help, :remission, :fields_required
  attr_accessor :required_fields_affecting_likelihood, :messages, :fields
  attr_accessor :final_decision_by
  attr_reader :inputs

  def initialize(attrs = {})
    local_attrs = convert_attrs(attrs.dup)
    self.fields_required = []
    self.required_fields_affecting_likelihood = []
    self.messages = []
    self.fields = {}
    self.available_help = :undecided
    self.final_decision_by = :none
    self.remission = 0.0
    self.inputs = {}
    super local_attrs
  end

  # Indicates if a calculator has made a final decision, preventing any further
  # calculations from being done.
  # This can be done by any calculator, but currently it is used by the
  # disposable capital calculator as it has the right to say - no more questions
  # this person has too much in savings.
  # @return [Boolean] Indicates if a final decision has been
  def final_decision_made?
    final_decision_by != :none
  end

  def assign_attributes(attrs)
    super(convert_attrs(attrs.dup))
  end

  def inputs=(v)
    @inputs = CalculationForm.new(v).export
  end

  private

  def convert_attrs(local_attrs)
    local_attrs
  end
end
