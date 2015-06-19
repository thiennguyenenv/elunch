class UsersController < ApplicationController
  layout :determine_layout

  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to '/admin/users'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :floor_id, :what_your_taste, :current_password, :password, :password_confirmation, :avatar, :progress_status, :admin)
  end
end
