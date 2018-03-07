class HelpController < ApplicationController
  layout "application_help"
  def total_income_include_exclude
    render locals: { return_to_path: params[:return_to_path] }
  end
end
