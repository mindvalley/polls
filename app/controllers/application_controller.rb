class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  layout :layout_by_resource
  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "application_unauthorized"
    end
  end

  def current_period
    date = Date.today << 1
    "#{date.strftime("%Y-%m")}"
  end

  rescue_from AccessDenied do |exception|
    redirect_to root_url, :alert => "Sorry, you are not authorized to login"
  end

end
