class SessionsController < ApplicationController
  def new
  end

  def create
    username, password = session_params.values
    user = User.find_by_credentials(username, password)

    unless user.is_a?(User)
      flash.now[:errors] = user

      render :new
    else
      session[:session_token] = user.reset_session_token!

      redirect_to user_url(user.id)
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to cats_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
