class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: %i[ new create ]
  before_action :redirect_if_authenticated, except: :destroy

  def new
    @user = User.build
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    return redirect_back(fallback_location: sessions_path, flash: { error: "Can't find email account." }) if @user.nil?

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_back(fallback_location: sessions_path, flash: { error: "Your email or password are incorrect." })
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
