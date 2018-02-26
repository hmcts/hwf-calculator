class CalculatorFieldCollection < FieldCollection
  FIELDS = [
    :marital_status, :fee, :date_of_birth, :partner_date_of_birth,
    :disposable_capital, :benefits_received, :number_of_children, :total_income
  ].freeze

  def fields_required
    FIELDS - validated_keys - keys_to_be_removed
  end

  def marital_status_will_change(new_value)
    invalidate_fields :disposable_capital, :number_of_children
    invalidate_field :partner_date_of_birth if new_value == 'sharing_income'
  end

  private

  def validated_keys
    fields.reject { |_k, v| v.invalidated }.keys
  end

  def keys_to_be_removed
    k = []
    k << :partner_date_of_birth if key?(:marital_status) && self[:marital_status] == 'single'
    k
  end
end
