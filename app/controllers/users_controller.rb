class UsersController < ApplicationController
  layout :determine_layout

  before_action :set_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @users = Kaminari.paginate_array(User.all).page(params[:page])
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    respond_with @user do |format|
      if @user.save
        format.html {redirect_to users_path, notice: "Create new user successfully!"}
      else
        format.html {redirect_to new_user_path, alert: @user.errors}
      end
    end
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
    if params[:action] = "create"
      params.require(:user).permit(:first_name, :last_name, :floor_id, :what_your_taste, :want_vegan_meal, :email, :password, :password_confirmation, :avatar, :progress_status, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :floor_id, :what_your_taste, :want_vegan_meal, :current_password, :password, :password_confirmation, :avatar, :progress_status, :admin)
    end
  end
end
