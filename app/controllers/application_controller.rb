class ApplicationController < ActionController::Base
  layout :layout
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def layout
    devise_controller? ? "subsidy_layout" : "application"
  end
end
