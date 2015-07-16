class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :confirm_logged_in, only: [:choose_table, :choose_vegan_table, :leave_table, :destroy]
  before_filter :configure_permitted_parameters
  # def new
  #   super
  # end

  def create
    # set flag to mark that avatar set up
    if params[:user][:avatar].present?
      params[:user][:progress_status] = 0b00000001
    end
    super
  end

  def destroy
    if current_user.tables.count > 0
      flash.now.alert = 'Cannot cancel your account. You need to leave all your tables first and try again.'
      return render 'edit'
    else
      super
    end
  end

  def update
    @user = User.find(current_user)
    if params[:user][:want_vegan_meal] == "0" && current_user.progress_status[2] == 1
      flash.now.alert = 'You need to leave your vegan table first and try again.'
      return render 'edit'
    end
    params[:user][:progress_status] |= 0b00000001 if params[:user][:avatar].present?
    successfully_updated = if need_password?(params)
      @user.update_with_password(params[:user].permit(:first_name, :last_name, :avatar, :floor_id, :what_your_taste, :want_vegan_meal, :current_password, :password, :password_confirmation, :progress_status))
    else
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user].permit(:first_name, :last_name, :avatar, :floor_id, :what_your_taste, :want_vegan_meal, :progress_status))
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
    table = Table.find(params[:user][:table_id])
    if table.for_vegans?
      normal_table_chart_on_vegan_days = current_user.tables_users.find { |tu| tu.table_id != table.id && tu.seating_chart_cat_id == 2 }
      if normal_table_chart_on_vegan_days.present?
        normal_table_chart_on_vegan_days.delete
        Table.find(normal_table_chart_on_vegan_days.table_id).empty_seat(current_user, 2)
      end
      unless current_user.tables_users.find { |tu| tu.table_id == table.id }
        current_user.tables_users.push TablesUser.new(table_id: table.id, user_id: current_user.id, seating_chart_cat_id: 2)
        table.add_seat(current_user, 2)
      end
      current_user.progress_status |= 0b00000100
    else
      unless current_user.tables_users.find { |tu| tu.table_id == table.id && tu.seating_chart_cat_id == 1 }
        current_user.tables_users.push TablesUser.new(table_id: table.id, user_id: current_user.id, seating_chart_cat_id: 1)
        table.add_seat(current_user, 1)
      end
      unless current_user.tables_users.find { |tu| tu.seating_chart_cat_id == 2 }
        current_user.tables_users.push TablesUser.new(table_id: table.id, user_id: current_user.id, seating_chart_cat_id: 2)
        table.add_seat(current_user, 2)
      end
      current_user.progress_status |= 0b00000010
    end

    current_user.save!
    redirect_to root_path
  end

  def leave_table
    leave_table = Table.find(params[:user][:table_id])
    current_user.tables_users.each do |tu|
      current_user.tables_users.destroy(tu) if tu.table_id == leave_table.id
    end
    leave_table.empty_seat(current_user)
    if leave_table.for_vegans?
      normal_table_chart_for_vegan_days = current_user.tables_users.find { |tu| tu.table_id != leave_table.id }
      if normal_table_chart_for_vegan_days.present?
        current_user.tables_users.push TablesUser.new(table_id: normal_table_chart_for_vegan_days.table_id, user_id: current_user.id, seating_chart_cat_id: 2)
        Table.find(normal_table_chart_for_vegan_days.table_id).add_seat(current_user, 2)
      end
      current_user.progress_status ^= 0b00000100
    else
      current_user.progress_status ^= 0b00000010
    end

    current_user.save!
    redirect_to root_path
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
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :current_password, :password, :password_confirmation, :avatar, :progress_status)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :current_password, :password, :password_confirmation, :avatar, :progress_status)
    end
  end
  def table_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :current_password, :password, :password_confirmation, :table_id)
  end
end
