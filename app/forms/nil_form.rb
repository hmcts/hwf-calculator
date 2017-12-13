class NilForm < BaseForm

  def type
    :nil
  end

  private

  def export_params
    {}
  end
end
