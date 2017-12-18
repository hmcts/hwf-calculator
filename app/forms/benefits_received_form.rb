# A form object for the benefits received question.
class BenefitsReceivedForm < BaseForm
  attribute :benefits_received, :array

  # The type of the form
  #
  # @return [Symbol] - :benefits_received
  def type
    :benefits_received
  end

  private

  def export_params
    {
      benefits_received: benefits_received
    }
  end
end
