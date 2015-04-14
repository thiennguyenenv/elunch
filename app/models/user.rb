class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, style: { medium: "300x300>", thumb: "100x100>"},
    path: ":rails_root/public/avatar/:id/:filename",
    url: "/avatar/:id/:filename"

  # For this: Paperclip::Errors::MissingRequiredValidatorError (Paperclip::Errors::MissingRequiredValidatorError)
  do_not_validate_attachment_file_type :avatar

  def admin?
    false
  end
end
