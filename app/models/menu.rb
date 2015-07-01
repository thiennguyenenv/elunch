class Menu < ActiveRecord::Base
  has_many :meals
  has_and_belongs_to_many :dishes

  validates :name, presence: true
  default_scope -> { order('created_at ASC') }
end
