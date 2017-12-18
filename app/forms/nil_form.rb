# A form object for when there is no form - which is used
# at the start of the form chain.  Simply avoids having ugly
# conditional stuff added by the caller.
class NilForm < BaseForm

  # The type of the form
  #
  # @return [Symbol] :nil
  def type
    :nil
  end

  private

  def export_params
    {}
  end
end
