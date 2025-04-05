class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'LINE') if is_navigational_format?
    else
      session['devise.line_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: 'LINE login failed'
    end
  end
end
