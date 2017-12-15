require 'active_model'
class BaseForm
  include ActiveModel::Model
  include ActiveModelAttributes

  def export
    export_params
  end

  private

  def export_params
    raise NotImplementedError
  end
end
