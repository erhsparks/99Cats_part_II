class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save

      redirect_to user_url(user.id)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new, helper_method: flash
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
