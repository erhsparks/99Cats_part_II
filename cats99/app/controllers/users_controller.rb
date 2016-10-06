class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)

    if user.valid?
      session[:session_token] = user.create_session_token
      user.save

      redirect_to user_url(user.id)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new, helper_method: flash
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.nil?
      if @user.username != current_user.username
      flash[:errors] = ["Don't try to access another person's profile!"]

      redirect_to cats_url
      else
        render :show
      end
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
