class Meal < ActiveRecord::Base
  attr_accessor :menu
  belongs_to :menus

  validates :meal_date, presence: true
  default_scope -> { order('created_at asc') }
  def menu
    Menu.find(self.menu_id) if self.menu_id.present?
  end
end
