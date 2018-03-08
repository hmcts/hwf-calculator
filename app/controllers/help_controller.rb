class HelpController < ApplicationController
  layout "application_help"

  helper_method :return_to_path

  def return_to_path
    URI.parse(params.require(:return_to_path)).path
  end
end
