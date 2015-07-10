class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tables_users
  has_many :tables, through: :tables_users

  has_attached_file :avatar, styles: { medium: "600x600#", thumb: "60x60#"}, :default_url => "/avatar/:style/user.png",
    path: ":rails_root/public/avatar/:id/:style_:filename",
    url: "/avatar/:id/:style_:filename"

  # For this: Paperclip::Errors::MissingRequiredValidatorError (Paperclip::Errors::MissingRequiredValidatorError)
  do_not_validate_attachment_file_type :avatar

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  default_scope -> { order('created_at ASC') }

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  def is_set_avatar?
    return self.progress_status[0] == 1
  end

  def is_choose_normal_table?
    return self.progress_status[1] == 1
  end

  def is_choose_vegan_table?
    return (self.progress_status[2] == 1 && self.want_vegan_meal?) || !self.want_vegan_meal?
  end

  private
  def reprocess_avatar
    avatar.reprocess!
  end
end
