class SessionsController < ApplicationController
  def new
    # TODO: redirect to root page when user is already logged in
    @user = User.build
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
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
