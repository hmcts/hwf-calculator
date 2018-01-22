# A form object for when only partial remission is available
# at the moment, this another type of Nil form, but may well
# get future functionality.
# @TODO Review this comment
class PartialRemissionAvailableForm < BaseForm

  # The type of the form
  #
  # @return [Symbol] :partial_remission_available
  def self.type
    :partial_remission_available
  end

  private

  def export_params
    {}
  end
end
