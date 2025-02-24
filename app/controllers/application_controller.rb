class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    desks_path
  end

  def after_sign_out_path_for(resource_or_scope)
    desks_path
  end
end
