# A form object for the benefits received question.
class BenefitsReceivedForm < BaseForm
  attribute :benefits_received, :array

  # The type of the form
  #
  # @return [Symbol] - :benefits_received
  def type
    :benefits_received
  end


  # @return [Array<Symbol>] An array of symbols representing the different types of benefits
  def benefits
    [:jobseekers_allowance, :employment_support_allowance, :income_support, :universal_credit, :pension_credit, :scottish_legal_aid, :none, :dont_know]
  end

  private

  def export_params
    {
      benefits_received: benefits_received
    }
  end
end
