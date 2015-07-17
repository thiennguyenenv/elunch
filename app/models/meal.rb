class Meal < ActiveRecord::Base
  acts_as_commentable
  attr_accessor :menu
  belongs_to :menus

  validates :meal_date, presence: true
  default_scope -> { order('meal_date asc') }
  def menu
    Menu.find(self.menu_id) if self.menu_id.present?
  end
end
