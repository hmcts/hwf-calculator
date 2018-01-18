require 'active_model'
# An abstract form object for the application, defining any common interfaces
# and providing the base functionality (attribute management and validation) for any sub forms
#
# Note that this uses an external gem called 'active_model_attributes' - this is because the rails
# project has added an attributes API to active model, but only implemented it in active record for now.
# It is assumed that the rails project will implement it in active model itself in the future, in the same
# way it is implemented in active record.  This gem fills in the gap for now, but can hopefully be removed in a
# future version of rails.
class BaseForm
  include ActiveModel::Model
  include ActiveModelAttributes

  # @!method valid?
  #   Indicates if the model passes all validations
  #   @return [Boolean] True if the form is valid, else false

  # The unique type code for the form
  #
  # @return [Symbol] The type of the form, underscored as a symbol. Used by the UI to select a presentation format
  def type
    raise NotImplementedError
  end

  # Exports the contents of the form as a hash with symbolized top level keys
  #
  # @return [Hash] The exported data with symbolized keys
  def export
    export_params
  end

  def self.new_ignoring_extras(attrs = {})
    new_attrs = attrs.slice(*attributes_registry.keys)
    new(new_attrs)
  end

  private

  # @abstract - Must have your own implementation in here, and it must return
  # symbolized keys as a standard (top level only - the rest is up to you)
  def export_params
    raise NotImplementedError
  end
end
