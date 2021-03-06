class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_apps
    @user = User.find_for_googleapps_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "GoogleApps"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.googleapps_data"] = request.env["omniauth.auth"]
      redirect_to root_url
    end
  end

  def new_session_path(*args)
  end
end
