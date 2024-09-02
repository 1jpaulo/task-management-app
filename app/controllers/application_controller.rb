class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  helper_method :redirect_if_authenticated
  helper_method :current_user
  before_action :require_authentication

  def require_authentication
    redirect_to(new_session_url, flash: { note: "You must sign in." }) if current_user.nil?
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def redirect_if_authenticated
    redirect_to(root_path, flash: { success: "You are currently logged in." }) if current_user.present?
  end
end
