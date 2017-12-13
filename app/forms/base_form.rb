require 'active_model'
class BaseForm
  include ActiveModel::Model
  include ActiveModelAttributes

  def i18n_scope
    "questions.#{id}"
  end

  def validate_date?(field)
    attribute = instance_variable_get("@#{field}")
    if attribute.is_a?(Date) || attribute.is_a?(Time)
      true
    else
      failure_reason = attribute.present? ? :not_a_date : :blank
      clear_and_set_error(field.to_sym, failure_reason)
      false
    end
  end

  def clear_and_set_error(attribute, validation)
    errors[attribute].clear
    errors.add(attribute, validation)
  end

  def id
    self.class.name.gsub('Forms::', '').underscore
  end
  alias to_param id

  def update_attributes(attributes)
    self.attributes = attributes
  end

  def permitted_attributes
    self.class.attribute_set.map(&:name)
  end

  def export
    export_params
  end

  def autocomplete
    Rails.env.development? ? 'on' : 'off'
  end

  private

  def export_params
    raise NotImplementedError
  end
end
