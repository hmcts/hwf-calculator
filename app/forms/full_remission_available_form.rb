# A form object for when full remission is available
# at the moment, this another type of Nil form, but may well
# get future functionality.
# @TODO Review this comment
class FullRemissionAvailableForm < BaseForm

  # The type of the form
  #
  # @return [Symbol] :full_remission_available
  def self.type
    :full_remission_available
  end

  private

  def export_params
    {}
  end
end
