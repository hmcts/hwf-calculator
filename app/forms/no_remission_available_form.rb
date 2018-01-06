# A form object for when no remission is available
# at the moment, this another type of Nil form, but may well
# get future functionality.
# @TODO Review this comment
class NoRemissionAvailableForm < BaseForm

  # The type of the form
  #
  # @return [Symbol] :no_remission_available
  def type
    :no_remission_available
  end

  private

  def export_params
    {}
  end
end
