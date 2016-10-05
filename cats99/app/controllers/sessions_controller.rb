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
      redirect_to user_url(user.id)
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
