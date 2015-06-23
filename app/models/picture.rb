class Picture < ActiveRecord::Base
  belongs_to :dishes

  has_attached_file :image,
    path: ":rails_root/public/images/:id/:filename",
    url: "/images/:id/:filename"

  # For this: Paperclip::Errors::MissingRequiredValidatorError (Paperclip::Errors::MissingRequiredValidatorError)
  do_not_validate_attachment_file_type :image
end
