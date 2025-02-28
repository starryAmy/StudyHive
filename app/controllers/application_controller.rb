class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :update_user_last_online, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    desks_path
  end

  def after_sign_out_path_for(resource_or_scope)
    desks_path
  end

  def update_user_last_online
    current_user.update_column(:last_online_at, Time.current)
  end
end
