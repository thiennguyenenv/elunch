module ApplicationHelper
  def bootstrap_class_for(type)
    case type
    when :errors
      "alert-error"
    when :alert
      "alert-warning"
    when :error
      "alert-error"
    when :notice
      "alert-success"
    else
      "alert-info"
    end
  end

  # This will make the devise resource mapping available and understandable in places other than the devise views.
  def resource_name
    :user
  end

  def resource
    @resource |= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
