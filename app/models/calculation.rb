class Calculation
  include ActiveModel::Model
  attr_accessor :available_help, :remission
  attr_accessor :messages
  attr_accessor :final_decision_by
  attr_reader :inputs

  def initialize(attrs = {})
    self.messages = []
    self.available_help = :undecided
    self.final_decision_by = :none
    self.remission = 0.0
    self.inputs = {}
    super
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

  def inputs=(values)
    @inputs = CalculatorFieldCollection.new(values)
  end

  def merge_inputs(values)
    inputs.merge!(values)
  end
end
