class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  def update
    @user = User.find(current_user)
    successfully_updated = if need_password?(params)
      @user.update_with_password(params[:user].permit(:first_name, :last_name, :avatar, :floor_id, :what_your_taste, :want_vegan_meal, :current_password, :password, :password_confirmation))
    else
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user].permit(:first_name, :last_name, :avatar, :floor_id, :what_your_taste, :want_vegan_meal))
    end

    if successfully_updated
      unless @user.tables.count == 0
        @user.tables.each do |table|
          table.update_cached_seats(@user)
        end
      end
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

  def choose_table
    @shifts = Shift.all
    render 'choose_table'
  end

  def choose_vegan_table
    @shifts = Shift.all
    @vegan = true
    render 'choose_table'
  end

  def join_table
    @table = Table.find(params[:user][:table_id])
    if @table.add_seat(current_user)
      current_user.update_without_password(params[:user].permit(:table_id))
    end
    render 'main/index'
  end

  def leave_table
    @table = Table.find(current_user.table_id)
    current_user.table_id = nil
    if @table.empty_seat(current_user.id)
      current_user.save
    end
    render 'main/index'
  end

  def crop
    @user = User.find(current_user)
    render 'crop'
  end

  private
  def need_password?(params)
    params[:user][:password].present? || params[:user][:password_confirmation].present?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :current_password, :password, :password_confirmation, :avatar)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :current_password, :password, :password_confirmation, :avatar)
    end
  end
  def table_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :current_password, :password, :password_confirmation, :table_id)
  end
end
