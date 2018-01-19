class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
  end
  def edit
    @user = User.find(params[:id])
    redirect_to user_path(@user) if @user != current_user
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "user was successfully updated"
    else
      render :edit
      flash[:alert] = "user was failed to update"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
