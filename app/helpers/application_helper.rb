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

  def error_messages(object)
    return "" if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: object.errors.count,
                      resource: object.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-alert">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <h4>#{sentence}</h4>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
