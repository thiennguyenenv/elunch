class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def determine_layout
    current_user.admin? ? "admin_layout" : "application"
  end

  protected
  def confirm_logged_in
    unless user_signed_in?
      flash[:notice] = "Please log in"
      redirect_to :root
      return false
    else
      return true
    end
  end
end
