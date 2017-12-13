class BenefitsReceivedForm < BaseForm
  attribute :benefits_received, :array

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
