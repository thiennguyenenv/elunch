class Dish < ActiveRecord::Base
  attr_accessor :categories
  has_many :pictures, :dependent => :destroy
  has_and_belongs_to_many :menus

  def categories
    Category.all
  end
end
