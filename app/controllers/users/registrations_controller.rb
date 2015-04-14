class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  # def new
  #   super
  # end

  # def create
  #   super
  # end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :floor_id, :what_your_taste, :email, :password, :password_confirmation)
    end
  end
end
