class Category < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }
end
