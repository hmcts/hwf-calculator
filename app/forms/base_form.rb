require 'active_model'
# An abstract form object for the application, defining any common interfaces
# and providing the base functionality (attribute management and validation) for any sub forms
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

  private

  # @abstract - Must have your own implementation in here, and it must return
  # symbolized keys as a standard (top level only - the rest is up to you)
  def export_params
    raise NotImplementedError
  end
end
