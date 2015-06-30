class Meal < ActiveRecord::Base
  attr_accessor :menu
  belongs_to :menus

  def menu
    Menu.find(self.menu_id) if self.menu_id.present?
  end
end
